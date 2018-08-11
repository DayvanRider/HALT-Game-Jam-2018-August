extends Node2D

# Axis normal describing the direction of expansion
export(Vector2) var expandDir = Vector2(0,-1)
# Max size the tile reaches
export(int) var expandAmount = 32
# Time after level start where the tile begins expanding
export(float) var startTime = 1
# Time after level start where the tile reaches max size
export(float) var endTime = 5

var startTimer = null
var expansionTimer = null

var relativeEndTime = null
var expansionStarted = false

var tileExtent = null
var additionalTiles = []

var originalShape = null


func _ready():
	checkExpandDir()
	initTimers()
	initAdditionalWalls()

func checkExpandDir():
	if expandDir.length() != 1 or abs(expandDir.x) + abs(expandDir.y) != 1:
		print("Expansion direction is not axis aligned!")
		get_tree().quit()

func initTimers():
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

func initAdditionalWalls():
	tileExtent = get_node("StaticBody2D2/CollisionShape2D").get_shape().get_extents() * 2
#	additionalWalls.append

func _process(delta):
	pass

func currentExpansion():
	if !expansionStarted:
		return 0
	var timeLeft = expansionTimer.get_time_left()
	if timeLeft == 0:
		return 1
	return (relativeEndTime - timeLeft) / relativeEndTime
