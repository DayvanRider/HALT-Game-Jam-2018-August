extends CollisionShape2D

var expandingTile = null
var expandDir = null
var expandAmount = null
var originalWidth = null

func _ready():
	expandingTile = get_node("../../")
	expandDir = expandingTile.expandDir
	originalWidth = shape.extents.x
	expandAmount = expandingTile.expandAmount

func _process(delta):
	updateCollisionShape()
	
func updateCollisionShape():
	var size = originalWidth + expandingTile.currentExpansion() * expandAmount
	shape.set_extents(Vector2(8, size))