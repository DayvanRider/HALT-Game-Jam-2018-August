extends Sprite

var expandingTile = null

func _ready():
	expandingTile = get_parent()
	# create the necessary amount of sprites

func _process(delta):
	position = expandingTile.currentExpansionDistance() * expandingTile.expandDir
