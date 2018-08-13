extends Area2D

var Collected


func _ready():
	set_visible(false)
	Collected = false;

#check for collision with Node called "Player"
func _physics_process(delta):
	if Collected == false:
		var bodies = get_overlapping_bodies()
		var touchingPlayer = false
		for b in bodies:
			if b.get_name() == "Player":
				get_parent().set_visible(false) 
				Collected = true
				collectSound()


#Returns the current state of the Gem
func is_collected():
	return Collected
	
func collectSound():
	var random = String(randi()%6+1)
	var path = "../GemSounds/GemSound" + random
	get_node(path).set_volume_db(-12.0) 
	#print("Play sound: ", random)
	get_node(path).play(0.000001)