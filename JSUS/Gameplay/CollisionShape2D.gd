extends CollisionShape2D

var expandingTile = null
var expandDir = null
var expandAmount = null
var originalShape = null

func _ready():
	expandingTile = get_node("../../")
	expandDir = expandingTile.expandDir
	expandAmount = expandingTile.expandAmount
	originalShape = get_shape()

func _process(delta):
	updateCollisionShape()
	
func updateCollisionShape():
	var size = originalShape.extents
	print(get_position())
	var newShape = originalShape
	set_shape(newShape)