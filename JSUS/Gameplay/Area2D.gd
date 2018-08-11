extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("/root/"
#	contacts_reported = 1
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	var touchingPlayer = false
	#Iterate through everybody
	#print("Gem is visible: " + String(get_node("Sprite").is_visible()))
	for b in bodies:
		if b.get_name() == "Player":
			touchingPlayer = true		#Player found!
			#print("Player Touched")
			get_node("../Sprite").set_visible(false) 
	
