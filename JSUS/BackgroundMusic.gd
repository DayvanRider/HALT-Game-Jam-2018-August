extends Node

var player = null

func _ready():
	print("Background music")
	var stream = load("res://assets/Audio/Music/egypt.wav")
	player = AudioStreamPlayer.new()
	add_child(player)
	player.set_stream(stream)
#	player.set_volume_db(0)
	player.play()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
