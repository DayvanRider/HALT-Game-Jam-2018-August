extends Area2D

var expTile = null

func _ready():
	set_visible(true)
	set_name("Expanding Tile")
	expTile = get_parent()
	pass

func _process(delta):
	set_position(expTile.currentExpansionDistance() * expTile.expandDir)
