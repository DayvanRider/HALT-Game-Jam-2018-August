extends CollisionShape2D

var expandingTile = null
var expandDir = null
var expandAmount = null
var baseExt = null
var baseExtents = null

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const RIGHT = Vector2(1, 0)
const LEFT = Vector2(-1, 0)

func _ready():	
	expandingTile = get_node("../../")
	expandAmount = expandingTile.expandAmount
	
	baseExt = shape.extents.x
	baseExtents = Vector2(baseExt, baseExt)
	
	# make those collision shapes unique
	set_shape(RectangleShape2D.new())

func _process(delta):
	expandTowardsMax()
	
func expandTowardsMax():
	# note that the extent is half the width of the shape
	var newExtents = Vector2()
	var newPosition = Vector2(0, 0)
	var addedExtent = expandingTile.currentExpansion() * expandAmount * .5
	
	match expandDir:
		UP:
			newExtents = baseExtents + Vector2(0, addedExtent)
			newPosition = Vector2(0, -addedExtent)
		DOWN:
			newExtents = baseExtents + Vector2(0, addedExtent)
			newPosition = Vector2(0, addedExtent)
		RIGHT:
			newExtents = baseExtents + Vector2(addedExtent, 0)
			newPosition = Vector2(addedExtent, 0)
		LEFT:
			newExtents = baseExtents + Vector2(addedExtent, 0)
			newPosition = Vector2(-addedExtent, 0)
	
	shape.extents = newExtents
	position = newPosition