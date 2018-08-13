extends Particles2D

var hasEmitted = false
var expTile = null
var expandDir = null setget set_expandDir
const width = 8

func _ready():
	expTile = get_parent()
	set_emitting(false)
	set_process_material(process_material.duplicate())
	set_visible(true)
	pass

func _process(delta):
	if expTile.finishedExpanding():
		emit()

func set_expandDir(newDir):
	set_position((expTile.expandAmount + width) * newDir)
	set_rotation((-newDir).angle())
	expandDir = newDir

func emit():
	if !hasEmitted:
		set_emitting(true)
		hasEmitted = true