extends KinematicBody2D
#constants
const SPEED = 300
const UP = Vector2(0,-1)
const JUMP = -500
export(int) var GRAVITY = 20
const WALLJUMPPAR = 1.25

var motion = Vector2(0,0)
var lastKey



func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_name("Player")
	var GemCount
	pass
	
func _physics_process(delta):
	#Add gravity
	motion.y += GRAVITY
	
	#left and right movement
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		#keep track of last keystroke
		lastKey = 1
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		#keep track of last keystroke
		lastKey = 2
	elif is_on_floor():
		motion.x = 0
		
	#Jump
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
		
	#if character is on wall
	if is_on_wall() && !is_on_floor():
		#slow down gravity 
		#TODO make modular
		if motion.y >0:
			motion.y -= (GRAVITY/4) * 3
		#make walljump by pressing up
		if Input.is_action_just_pressed("ui_up"):
			#determine wall by last keystroke
			if lastKey == 1:
				motion.y = WALLJUMPPAR*JUMP
				motion.x = -SPEED
			if lastKey == 2:
				motion.y = WALLJUMPPAR*JUMP
				motion.x = SPEED
	
	#only update motion if character is on the ground 
	var motiontmp = move_and_slide(motion,UP)
	if is_on_floor():
		motion = motiontmp
