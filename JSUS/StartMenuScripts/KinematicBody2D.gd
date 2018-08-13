extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MOVETIME = 100
var motion = Vector2(0,7)
var UP = Vector2(0,-1)
var i = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	move_and_slide(motion,UP)
	i += 1 
	if i > MOVETIME:
		motion.y = -motion.y
		i = 0
