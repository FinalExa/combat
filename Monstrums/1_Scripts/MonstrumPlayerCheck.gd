class_name MonstrumPlayerCheck
extends Area2D

var player: Player

func _on_body_entered(body):
	if (body is Player):
		player = body

func _on_body_exited(body):
	if (body is Player):
		player = null
