extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var size = get_node("../").currentExpansion() * get_region_rect().size.x
	set_scale(Vector2(size,size))
