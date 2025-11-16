extends Monstrum_Node

@export var monstrumMovement: MonstrumMovement
@export var monstrumPlayerCheck: MonstrumPlayerCheck

func Evaluate(_delta):
	if (monstrumMovement.target == null):
		monstrumMovement.SetNodeTarget(monstrumPlayerCheck.player)
	return NodeState.SUCCESS
