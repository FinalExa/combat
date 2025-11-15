class_name GameCamera
extends Camera2D

@export var playerRef: Player
@export var followPlayer: bool

func _process(_delta):
	FollowPlayer()

func FollowPlayer():
	if (followPlayer && self.get_parent() != playerRef):
		self.reparent(playerRef)
		self.global_position = playerRef.global_position
