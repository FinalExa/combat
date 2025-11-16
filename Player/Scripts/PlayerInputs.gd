class_name PlayerInputs
extends Node

var inputDirection: Vector2
var mainAction: bool
var secondaryAction: bool

func _process(_delta):
	CheckForInputs()

func CheckForInputs():
	GetMovementInput()

func GetMovementInput():
	inputDirection = Input.get_vector("left", "right", "up", "down")
	mainAction = GetInput(Input.is_action_just_pressed("main_action"))
	secondaryAction = GetInput(Input.is_action_just_pressed("secondary_action"))

func GetInput(input: bool):
	if (input):
		return true
	return false
