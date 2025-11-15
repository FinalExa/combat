class_name PlayerMovement
extends Node

@export var player: Player
@export var playerInputs: PlayerInputs

@export var maxSpeed: float
@export var acceleration: float
var currentSpeed: float

func _physics_process(delta):
	SetSpeed(delta)

func SetSpeed(delta):
	if (playerInputs.inputDirection != Vector2.ZERO):
		currentSpeed = clamp(currentSpeed + (acceleration * delta), 0, maxSpeed)
		player.velocity = currentSpeed * playerInputs.inputDirection
		player.move_and_slide()
		return
	currentSpeed = 0
	player.velocity = Vector2.ZERO
