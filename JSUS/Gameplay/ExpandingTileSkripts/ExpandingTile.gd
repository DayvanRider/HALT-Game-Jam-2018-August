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
export(Texture) var tileTexture = null
export(Rect2) var tileRegion = Rect2(16, 0, 16, 16)
export(Texture) var wallTexture = null
export(Rect2) var wallRegion = Rect2(16, 16, 16, 16)

var startTimer = null
var expansionTimer = null

var expansionStarted = false

var tileExtent = null
var additionalTiles = []


func _ready():
	initSprites()
	initExpandDir()
	initTimers()
	initAdditionalWalls()

func initSprites():
	if tileTexture != null:
		var tileSprite = get_node("TileSprite")
		tileSprite.set_texture(tileTexture)
		tileSprite.set_region(true)
		tileSprite.set_region_rect(tileRegion)
	
	if wallTexture != null:
		var wallSpriteController = get_node("WallSpriteController")
		wallSpriteController.setTexture(wallTexture)
		wallSpriteController.setTextureRegion(wallRegion)
	

func initExpandDir():
	expandDir = axisMap[expansionAxis]
	get_node("StaticBody2D/CollisionShape2D").expandDir = expandDir

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
	return (duration - timeLeft) / duration
	
func currentExpansionDistance():
	return currentExpansion() * expandAmount
