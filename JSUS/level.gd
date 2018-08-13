extends Node2D

#constants

var nextLevel = "res://Levels/lvl_till_easy.tscn"


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
		
	

func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
