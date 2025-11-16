class_name AttackData
extends Resource

@export var launchFrame: int
@export var hitbox: NodePath
@export var sound: NodePath
@export var movement: float

func GetHitboxFromPath(source: Attack):
	return source.get_node_or_null(hitbox)

func GetSoundFromPath(source: Attack):
	return source.get_node_or_null(sound)
