extends Node

export (bool) var playGateSound = true
var gemsCollected
var gemsTotal
var scoreText
var isOpened = false

func _ready():
	get_node("AudioStreamPlayer").stop()
	set_draw_behind_parent(true) 
	get_node("Sprite").stop()
	get_node("Sprite").frame = 0
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	gemsTotal = 0
	gemsCollected = 0

	var bodies = get_node("Area2D").get_overlapping_bodies()
	var gems = get_children()
	var allGemsCollected = true

	for gem in gems:
		if gem.name.begins_with("Gem"):
			gemsTotal += 1
			
			
			if gem.get_node("Area2D").is_collected() == true:
				gemsCollected += 1
			else:
				allGemsCollected = false
				
	
	for b in bodies:
		if b.get_name() == "Player":
			if allGemsCollected:
				get_tree().change_scene(get_parent().nextLevel)
				#b.kill()
	
	scoreText = String(gemsCollected) + " / " + String(gemsTotal)
	get_node("Score").set_text(scoreText)
	
	
	if allGemsCollected:
		get_node("Sprite").play()
		if (playGateSound and !isOpened):
			isOpened = true
			get_node("AudioStreamPlayer").play()
		pass
		#print("Hooray You finished the Level!")
		#ADD next Level Command here!




			
