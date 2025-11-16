class_name PlayerRotator
extends Node2D

@export var upRad = 0
@export var downRad = 0
@export var leftRad = 0
@export var rightRad = 0
var lastDirection: Vector2
var lastSavedDirection: Vector2 = Vector2(0, -1)

func Rotate(direction: Vector2):
	HorizontalRotation(direction)
	VerticalRotation(direction)
	lastDirection = direction
	if (lastDirection != lastSavedDirection && lastDirection != Vector2.ZERO):
		lastSavedDirection = lastDirection
	print(self.rotation_degrees)

func VerticalRotation(direction: Vector2):
	if (direction.y != lastDirection.y):
		if (direction.y < 0):
			self.rotation_degrees = upRad
		else: 
			if (direction.y > 0):
				self.rotation_degrees = downRad

func HorizontalRotation(direction: Vector2):
	if (direction.x != lastDirection.x):
		if (direction.x < 0):
			self.rotation_degrees = leftRad
		else: 
			if (direction.x > 0):
				self.rotation_degrees = rightRad

func GetCurrentLookDirection():
	return lastSavedDirection
