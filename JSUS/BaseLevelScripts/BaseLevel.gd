extends Node

export(String, FILE, "*.tscn") var nextLevel

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()