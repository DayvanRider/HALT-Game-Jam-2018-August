extends Node

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != 00:
			get_tree().change_scene("res://Levels/Tutorial/tutorial1.tscn")