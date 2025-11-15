class_name PlayerInputs
extends Node

var inputDirection: Vector2

func _process(_delta):
	CheckForInputs()

func CheckForInputs():
	GetMovementInput()

func GetMovementInput():
	inputDirection = Input.get_vector("left", "right", "up", "down")

func GetInput(input: bool):
	if (input):
		return true
	return false
