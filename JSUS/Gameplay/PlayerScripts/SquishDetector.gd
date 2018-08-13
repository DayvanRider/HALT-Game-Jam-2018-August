extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#func _ready():
#	# Called when the node is added to the scene for the first time.
#	# Initialization here
#	pass

#func _process(delta):
#	print(isOverlappingObjects())
		
func isOverlappingObjects():
	var expTileCount = 0
	for area in get_overlapping_areas():
		if area.get_name() == "Expanding Tile":
			expTileCount += 1
	return (expTileCount > 0
		or get_overlapping_bodies().size() > 1)