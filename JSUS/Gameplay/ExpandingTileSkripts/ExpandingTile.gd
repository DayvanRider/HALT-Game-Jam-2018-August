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
# Time after level start where the tile begins expanding, in seconds
export(float) var startTime = 1
# Time the tile takes to reache its max size after starting, in seconds
export(float) var duration = 4

# Texture customization
export(Texture) var wallTexture = null
const width = 16
export(Vector2) var wallSprite = Vector2(1, 1)
export(Vector2) var capSprite = Vector2(1, 1)

var startTimer = null
var expansionTimer = null

var expansionStarted = false

var tileExtent = null
var additionalTiles = []

var isFullyExtended = false			#Flag, to check if Tile is already extended


func _ready():
	initSprites()
	initExpandDir()
	initTimers()

func initSprites():
	if wallTexture != null:
		var wallSpriteController = get_node("WallSpriteController")
		wallSpriteController.setTexture(wallTexture)
		wallSpriteController.setTextureRegion(coordToRegion(wallSprite))
		wallSpriteController.setCapTextureRegion(coordToRegion(capSprite))
		

func coordToRegion(coord):
	return Rect2(coord.x * width, coord.y * width, width, width)

func initExpandDir():
	expandDir = axisMap[expansionAxis]
	get_node("StaticBody2D/CollisionShape2D").expandDir = expandDir
	get_node("Particles2D").set_expandDir(expandDir)

func initTimers():
	startTimer = get_node("StartTimer")
	expansionTimer = get_node("ExpansionTimer")
	
	startTimer.set_wait_time(startTime)
	startTimer.set_one_shot(true)
	expansionTimer.set_wait_time(duration)
	expansionTimer.set_one_shot(true)
	
	startTimer.connect("timeout", self, "onStartTimer")
	
	startTimer.start()

func onStartTimer():
	expansionStarted = true
	expansionTimer.start()

func _process(delta):
	if (currentExpansion() == 1) && (isFullyExtended == false):
		isFullyExtended = true
		get_node("Thump").set_volume_db(-12.0)
		get_node("Thump").play(0.000001)

func currentExpansion():
	if !expansionStarted:
		return 0
	var timeLeft = expansionTimer.get_time_left()
	if timeLeft == 0:
		return 1
	return (duration - timeLeft) / duration
	
func currentExpansionDistance():
	return currentExpansion() * expandAmount
	
func finishedExpanding():
	return currentExpansionDistance() == expandAmount