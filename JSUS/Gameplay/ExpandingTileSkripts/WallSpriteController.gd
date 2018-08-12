extends Node2D

const width = 16
var texture = ImageTexture.new() setget setTexture
var textureRegion = Rect2(width, width, width, width) setget setTextureRegion
var sprites = []

var expandingTile = null

func _ready():
	expandingTile = get_parent()
	# default texture
	var image = Image.new()
	image.load("res://assets/Tiles/Tiles.png")
	texture.create_from_image(image, 0)
	# create necessary amount of sprites
	var spriteNumber = ceil(expandingTile.expandAmount / width)
	for i in range(spriteNumber):
		var newSprite = createSprite()
		sprites.push_back(newSprite)
	print(sprites)

func setTexture(newTexture):
	for sprite in sprites:
		sprite.set_texture(newTexture)
	texture = newTexture

func setTextureRegion(newRegion):
	for sprite in sprites:
			sprite.set_region_rect(newRegion)
	textureRegion = newRegion

func createSprite():
	var newSprite = Sprite.new()
	newSprite.set_region(true)
	newSprite.set_texture(texture)
	newSprite.set_region_rect(textureRegion)
	add_child(newSprite)
	return newSprite

func _process(delta):
	for idx in range(sprites.size()):
		moveSprite(sprites[idx], idx)
	print(textureRegion)

func moveSprite(sprite, index):
	# only move if expansion distance is large enough
	if expandingTile.currentExpansionDistance() - index * width > 0:
		var expDist = expandingTile.currentExpansionDistance()
		var distAdjustedByIdx = expDist - index * width
		var newPos = distAdjustedByIdx * expandingTile.expandDir
		sprite.set_position(newPos)