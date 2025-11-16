extends Monstrum_Node

@export var monstrumMovement: MonstrumMovement
@export var monstrumPlayerCheck: MonstrumPlayerCheck

func Evaluate(_delta):
	if (monstrumPlayerCheck.player != null):
		return NodeState.FAILURE
	if (monstrumMovement.target != null && monstrumMovement.target is Player):
		monstrumMovement.SetNodeTarget(null)
	return NodeState.SUCCESS
