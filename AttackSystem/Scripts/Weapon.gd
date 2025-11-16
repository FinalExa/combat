class_name Weapon
extends Node2D

@export var characterRef: Node2D
@export var baseDamage: float
@export var playerInputs: PlayerInputs
@export var baseMainAttack: PlayerAttack
@export var baseSecondaryAttack: PlayerAttack
@export var comboResetTime: float
@export var comboEndCooldown: float
var resetTimer: float
var endTimer: float

var comboInput: ComboAttackInput = ComboAttackInput.NONE
var comboLaunched: bool
var currentAttack: PlayerAttack
var endCooldown: bool

enum ComboAttackInput
{
	MAIN,
	SECONDARY,
	NONE
}

func _process(delta):
	CheckForInput()
	ComboProgression(delta)
	ComboEndTimer(delta)

func CheckForInput():
	if (!endCooldown):
		if (comboInput == ComboAttackInput.NONE):
			if (playerInputs.mainAction):
				comboInput = ComboAttackInput.MAIN
				return
			if (playerInputs.secondaryAction):
				comboInput = ComboAttackInput.SECONDARY

func ComboProgression(delta):
	if (comboLaunched && currentAttack.attackLaunched && currentAttack.mainAttackFollow == null && currentAttack.secondaryAttackFollow == null):
		EndAttack()
	if (comboInput != ComboAttackInput.NONE):
		resetTimer = comboResetTime
		if (!comboLaunched):
			comboLaunched = LaunchComboAttack()
			comboInput = ComboAttackInput.NONE
			return
		if (comboLaunched && !currentAttack.attackLaunched):
			LaunchComboAttack()
			comboInput = ComboAttackInput.NONE
	if (comboLaunched && !currentAttack.attackLaunched):
		ResetTimer(delta)

func LaunchComboAttack():
	if (currentAttack == null):
		return FirstAttack()
	ChainAttack()

func FirstAttack():
	if (comboInput == ComboAttackInput.MAIN && baseMainAttack != null):
		currentAttack = baseMainAttack
		currentAttack.StartAttack()
		return true
	if (comboInput == ComboAttackInput.SECONDARY && baseSecondaryAttack != null):
		currentAttack = baseSecondaryAttack
		currentAttack.StartAttack()
		return true
	return false

func ChainAttack():
	if (comboInput == ComboAttackInput.MAIN && currentAttack.mainAttackFollow != null):
		currentAttack = currentAttack.mainAttackFollow
		currentAttack.StartAttack()
		return true
	if (comboInput == ComboAttackInput.SECONDARY && currentAttack.secondaryAttackFollow != null):
		currentAttack = currentAttack.secondaryAttackFollow
		currentAttack.StartAttack()
		return true
	return false

func EndAttack():
	endTimer = comboEndCooldown
	currentAttack = null
	comboLaunched = false
	endCooldown = true

func ComboEndTimer(delta):
	if (endCooldown):
		if (endTimer > 0):
			endTimer -= delta
			return
		endCooldown = false

func ResetTimer(delta):
	if (currentAttack != null && currentAttack.mainAttackFollow == null && currentAttack.secondaryAttackFollow == null):
		resetTimer = 0
	if (resetTimer > 0):
		resetTimer -= delta
		return
	EndAttack()
