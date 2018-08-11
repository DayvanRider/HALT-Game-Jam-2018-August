extends Node2D

# Axis normal describing the direction of expansion
export(Vector2) var expandDir = Vector2(0,-1)
# Max size the tile reaches
export(int) var expandAmount = 64
# Time after level start where the tile begins expanding
export(float) var startTime = 1
# Time after level start where the tile reaches max size
export(float) var endTime = 5

var startTimer = null
var expansionTimer = null

var relativeEndTime = null
var expansionStarted = false


func _ready():
	relativeEndTime = endTime - startTime
	
	startTimer = get_node("StartTimer")
	expansionTimer = get_node("ExpansionTimer")
	
	startTimer.set_wait_time(startTime)
	startTimer.set_one_shot(true)
	expansionTimer.set_wait_time(relativeEndTime)
	expansionTimer.set_one_shot(true)
	
	startTimer.connect("timeout", self, "onStartTimer")
	
	print("Starting timer")
	startTimer.start()
	

func onStartTimer():
	expansionStarted = true
	expansionTimer.start()
	

func _process(delta):
	pass
	
func currentExpansion():
	if !expansionStarted:
		return 0
	var timeLeft = expansionTimer.get_time_left()
	if timeLeft == 0:
		return 1
	return (relativeEndTime - timeLeft) / relativeEndTime
