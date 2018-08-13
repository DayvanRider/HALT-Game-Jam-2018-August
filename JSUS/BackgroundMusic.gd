extends Node

var player = null

func _ready():
	var stream = load("res://assets/Audio/Music/egypt.ogg")
	stream.set_loop(true)
	
	player = AudioStreamPlayer.new()
	add_child(player)
	player.set_stream(stream)
	player.set_volume_db(-12)
	player.play()
	pass
