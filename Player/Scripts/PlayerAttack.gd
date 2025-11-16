class_name PlayerAttack
extends Attack

@export var mainAttackFollow: PlayerAttack
@export var secondaryAttackFollow: PlayerAttack
@export var hitMultiplier: float = 100

func FinalizeAttack():
	attackLaunched = false

func StartCooldown():
	attackInCooldown = true
	attackFrame = 0
	EndCooldownFeedback()

func ForceStopAttack():
	ForceEndAttack()
	ForceEndCooldown()
	attackLaunched = false

func ForceEndCooldown():
	if (attackInCooldown):
		attackInCooldown = false
		attackFrame = 0
