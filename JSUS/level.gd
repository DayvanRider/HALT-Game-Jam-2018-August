extends Node2D

#constants



func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
		
	

func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		print("test")
		get_tree().reload_current_scene()
