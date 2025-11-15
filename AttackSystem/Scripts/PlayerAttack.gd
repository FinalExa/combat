class_name PlayerAttack
extends Attack

@export var attackTag: String

func _process(_delta):
	CheckForInput()

func CheckForInput():
	if (!attackLaunched && characterRef.playerInputs.attackInput && !characterRef.transformationChangeRef.isTransformed):
		characterRef.playerMovement.DisableMovement()
		start_attack()

func FinalizeAttack():
	characterRef.playerMovement.EnableMovement()
	attackLaunched = false

func StartCooldown():
	attackInCooldown = true
	attackFrame = 0
	EndCooldownFeedback()
	characterRef.playerMovement.EnableMovement()

func ForceStopAttack():
	ForceEndAttack()
	ForceEndCooldown()
	attackLaunched = false

func ForceEndCooldown():
	if (attackInCooldown):
		attackInCooldown = false
		attackFrame = 0
