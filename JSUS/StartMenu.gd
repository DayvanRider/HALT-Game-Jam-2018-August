extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _input(event):
    
	if event is InputEventKey and event.pressed:
		if event.scancode != 00:
			get_tree().change_scene("res://level.tscn")

func _process(delta):
	pass
		
