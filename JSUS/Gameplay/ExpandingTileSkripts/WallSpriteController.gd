extends Node

const width = 16
var texture = ImageTexture.new() setget setTexture
var textureRegion = Rect2(width, width, width, width) setget setTextureRegion
var capTextureRegion = Rect2(width, width, width, width) setget setCapTextureRegion
var sprites = []

var expandingTile = null
var basePosition = null

func _ready():
	expandingTile = get_parent()
	basePosition = expandingTile.get_global_position()
	# default texture
	var image = Image.new()
	image.load("res://assets/Tiles/Tiles.png")
	texture.create_from_image(image, 0)
	# create necessary amount of sprites
	var spriteNumber = ceil(expandingTile.expandAmount / width)
	for i in range(spriteNumber):
		var newSprite = createSprite()
		sprites.push_back(newSprite)
	sprites.front().set_region_rect(capTextureRegion)

func setTexture(newTexture):
	for sprite in sprites:
		sprite.set_texture(newTexture)
	texture = newTexture

func setTextureRegion(newRegion):
	for sprite in sprites:
			sprite.set_region_rect(newRegion)
	textureRegion = newRegion

func setCapTextureRegion(newRegion):
	sprites.front().set_region_rect(newRegion)
	capTextureRegion = newRegion

func createSprite():
	var newSprite = Sprite.new()
	newSprite.set_region(true)
	newSprite.set_texture(texture)
	newSprite.set_region_rect(textureRegion)
	# move away from screen
	newSprite.set_position(Vector2(-100,-100)) 
	newSprite.set_z_index(5)
	newSprite.set_z_as_relative(false)
	add_child(newSprite)
	return newSprite

func _process(delta):
	for idx in range(sprites.size()):
		moveSprite(sprites[idx], idx)

func moveSprite(sprite, index):
	# only move if expansion distance is large enough
	if expandingTile.currentExpansionDistance() - index * width > 0:
		var expDist = expandingTile.currentExpansionDistance()
		var distAdjustedByIdx = expDist - index * width
		var newPos = basePosition + distAdjustedByIdx * expandingTile.expandDir
		sprite.set_position(newPos)