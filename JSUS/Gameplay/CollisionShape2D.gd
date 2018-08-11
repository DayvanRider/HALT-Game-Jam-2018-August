extends CollisionShape2D

var expandingTile = null
var expandDir = null
var expandAmount = null
var originalExtent = null

func _ready():
	expandingTile = get_node("../../")
	expandDir = expandingTile.expandDir
	expandAmount = expandingTile.expandAmount
	originalExtent = get_shape().get_extents()

func _process(delta):
	var newSize = expandingTile.currentExpansion() * expandAmount
	get_shape().set_extents(Vector2(newSize,newSize))
	print(get_shape().get_extents())