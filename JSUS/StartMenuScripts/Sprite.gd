extends Sprite

var startPosition = null

func _ready():
	startPosition = get_position()

func _process(delta):
	var change = sin(OS.get_ticks_msec() / 1000.0) * 5
	set_position(startPosition + Vector2(0, change))
