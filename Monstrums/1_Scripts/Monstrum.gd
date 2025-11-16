class_name Monstrum
extends CharacterBody2D

@export var monstrumReferences: MonstrumReferences

func _physics_process(delta):
	move_and_slide()
