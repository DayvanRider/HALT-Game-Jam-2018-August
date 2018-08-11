extends Node2D

var axisMap = {
	"Up": Vector2(0, -1),
	"Down": Vector2(0, 1),
	"Left": Vector2(-1, 0),
	"Right": Vector2(1, 0),
}

# Axis normal describing the direction of expansion
export(String, "Up", "Down", "Left", "Right") var expansionAxis = "Up"
var expandDir = null
# Max size the tile reaches
export(int, 0, 640, 16) var expandAmount = 32
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


func _ready():
	initExpandDir()
	initTimers()
	initAdditionalWalls()

func initExpandDir():
	expandDir = axisMap[expansionAxis]
	get_node("StaticBody2D/CollisionShape2D").expandDir = expandDir

func initTimers():
	relativeEndTime = endTime - startTime
	
	startTimer = get_node("StartTimer")
	expansionTimer = get_node("ExpansionTimer")
	
	startTimer.set_wait_time(startTime)
	startTimer.set_one_shot(true)
	expansionTimer.set_wait_time(relativeEndTime)
	expansionTimer.set_one_shot(true)
	
	startTimer.connect("timeout", self, "onStartTimer")
	
	startTimer.start()

func onStartTimer():
	expansionStarted = true
	expansionTimer.start()

func initAdditionalWalls():
	tileExtent = get_node("StaticBody2D/CollisionShape2D").get_shape().get_extents() * 2
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
