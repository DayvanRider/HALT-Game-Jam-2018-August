extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var MovementPhase
var Movement

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	MovementPhase = 0
	pass

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	var touchingPlayer = false
	for b in bodies:
		if b.get_name() == "Player":
			b.kill()
		

