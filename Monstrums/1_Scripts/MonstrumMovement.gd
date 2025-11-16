class_name MonstrumMovement
extends NavigationAgent2D

signal reached_destination

@export var monstrumRef: Monstrum

@export var defaultMovementSpeed: float
@export var distanceTolerance: float
@export var repathTimerDuration: float
var repathTimer: float
var currentMovementSpeed: float
var target: Node2D
var locationTarget: Vector2
var locationTargetEnabled: bool
var waitNextFrame: bool

func _ready():
	repathTimer = 0
	ResetMovementSpeed()

func _physics_process(delta):
	if((target != null || locationTargetEnabled)):
		if (!waitNextFrame):
			waitNextFrame = true
			return
		Navigate(delta)
		PathNavigation()

func UpdateNavigationPath(end_position):
	self.target_position = end_position
	if (monstrumRef.global_position == end_position):
		monstrumRef.velocity = Vector2.ZERO

func PathNavigation():
	var movementSpeed = currentMovementSpeed
	var dir = monstrumRef.global_position.direction_to(self.get_next_path_position())
	monstrumRef.velocity = dir * movementSpeed
	if ((locationTargetEnabled && monstrumRef.global_position.distance_to(locationTarget) < distanceTolerance)
	|| (target != null && monstrumRef.global_position.distance_to(target.global_position) < distanceTolerance)):
		monstrumRef.velocity = Vector2.ZERO
		emit_signal("reached_destination")

func SetNodeTarget(newTarget):
	target = newTarget
	locationTarget = Vector2.ZERO
	locationTargetEnabled = false
	RePath()

func SetPositionTarget(locTarget: Vector2):
	locationTarget = locTarget
	target = null
	locationTargetEnabled = true
	RePath()

func Navigate(delta):
	if (repathTimer > 0):
		repathTimer -= delta
	else:
		RePath()
		repathTimer = repathTimerDuration

func RePath():
	if(target != null):
		UpdateNavigationPath(target.global_position)
	else:
		if (locationTargetEnabled):
			UpdateNavigationPath(locationTarget)
		else:
			UpdateNavigationPath(monstrumRef.global_position)

func SetMovementSpeed(newMovementSpeed: float):
	currentMovementSpeed = newMovementSpeed

func ResetMovementSpeed():
	currentMovementSpeed = defaultMovementSpeed
