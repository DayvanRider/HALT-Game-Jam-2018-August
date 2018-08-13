extends Sprite

const period = 2000

func _process(delta):
	if OS.get_ticks_msec() % period < period / 2:
		set_visible(true)
	else:
		set_visible(false)
