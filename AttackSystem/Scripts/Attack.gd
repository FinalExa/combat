class_name Attack
extends Node2D

signal on_attack_end

@export var attackDuration: int
@export var attackCooldown: int
@export var attackData: Array[AttackData]
@export var weaponRef: Weapon
@export var characterRef: Node2D
var frameMaster: FrameMaster
var attackHitboxInstance: Node2D
var movementValue: float
var movementDirection: Vector2

var attackLaunched: bool
var attackInCooldown: bool
var attackFrame: int
var currentPhase: int
var attackLocked: bool

func _ready():
	if (weaponRef != null && characterRef == null):
		characterRef = weaponRef.characterRef
	frameMaster = get_tree().root.get_child(0).frameMaster
	frameMaster.RegisterAttack(self)
	attackLocked = false
	RemoveAttackHitboxes()
	currentPhase = 0
	ExtraReadyOperations()
	
func ExtraReadyOperations():
	pass

func AddAttackHitbox(index):
	if (index < attackData.size()):
		var sound: AudioStreamPlayer = attackData[index].GetSoundFromPath(self)
		if (sound != null && !sound.playing):
			sound.play()
		attackHitboxInstance = attackData[index].GetHitboxFromPath(self)
		if (attackHitboxInstance != null):
			if (attackHitboxInstance is AttackHitbox):
				attackHitboxInstance.StartAttack()
				attackHitboxInstance.characterRef = characterRef
				return
			if (attackHitboxInstance is ObjectSpawner):
				attackHitboxInstance.SpawnObject()
				return
			ActivateOtherTypeOfAttackHitbox()

func RemoveAttackHitbox(index):
	if (index < attackData.size() && attackData[index] != null):
		attackHitboxInstance = attackData[index].GetHitboxFromPath(self)
		if (attackHitboxInstance != null):
			if (attackHitboxInstance is AttackHitbox):
				attackHitboxInstance.EndAttack()
				return
			if (attackHitboxInstance is ObjectSpawner):
				return
			DeactivateOtherTypeOfAttackHitbox()

func ActivateOtherTypeOfAttackHitbox():
	attackHitboxInstance.show()
	for i in attackHitboxInstance.get_child_count():
		if (attackHitboxInstance.get_child(i) is CollisionShape2D || attackHitboxInstance.get_child(i) is CollisionPolygon2D):
			attackHitboxInstance.get_child(i).disabled = false

func DeactivateOtherTypeOfAttackHitbox():
	attackHitboxInstance.hide()
	for i in attackHitboxInstance.get_child_count():
		if (attackHitboxInstance.get_child(i) is CollisionShape2D || attackHitboxInstance.get_child(i) is CollisionPolygon2D):
			attackHitboxInstance.get_child(i).disabled = true

func StartAttack():
	if (!attackLocked):
		attackLaunched = true
		attackFrame = 0
		characterRef.velocity = Vector2.ZERO
		ExecuteAttackPhase()

func ExecuteAttackPhase():
	PrepareHitboxes()
	currentPhase += 1
	CalculateCurrentAttackMovement(currentPhase - 1)

func PrepareHitboxes():
	if (currentPhase > 0):
		RemoveAttackHitbox(currentPhase - 1)
	AddAttackHitbox(currentPhase)

func EndAttack():
	if (currentPhase >= attackData.size()):
		RemoveAttackHitbox(attackData.size() - 1)
		currentPhase = 0
		CheckForCooldown()
		OnAttackEnd()

func CheckForCooldown():
	if (attackCooldown == 0):
		attackLaunched = false
	else:
		StartCooldown()

func ForceEndAttack():
	if (attackLaunched && !attackInCooldown):
		StopAllSounds()
		RemoveAttackHitboxes()
		currentPhase = 0
		CheckForCooldown()
		OnAttackEnd()

func StartCooldown():
	attackInCooldown = true
	attackFrame = 0

func EndCooldown():
	attackInCooldown = false
	attackLaunched = false
	EndCooldownFeedback()

func Attacking():
	if (attackLaunched):
		if (!attackInCooldown):
			if (attackFrame < attackDuration):
				AttackMovement(currentPhase - 1)
				attackFrame += 1
				if (currentPhase < attackData.size() && attackFrame > attackData[currentPhase].launchFrame):
					ExecuteAttackPhase()
			else:
				EndAttack()
		else:
			if (attackFrame < attackCooldown):
				ActiveCooldownFeedback()
				attackFrame += 1
			else:
				EndCooldown()

func RemoveAttackHitboxes():
	for i in attackData.size():
		RemoveAttackHitbox(i)

func CalculateCurrentAttackMovement(index: int):
	if (attackData.size() > 0 && attackData[index].movement != null):
		pass
		#movementDirection = characterRef.GetRotator().get_current_look_direction()

func AttackMovement(index: int):
	if (attackData.size() > 0 && index < attackData.size() && attackData[index].movement != null):
		var velocityValue: Vector2 = attackData[index].movement * movementDirection
		characterRef.velocity = velocityValue

func StopAllSounds():
	for i in attackData.size():
		var sound: AudioStreamPlayer = attackData[i].GetSoundFromPath(self)
		if (sound != null && sound.playing):
			sound.stop()

func ActiveCooldownFeedback():
	pass

func EndCooldownFeedback():
	pass

func OnAttackEnd():
	pass
