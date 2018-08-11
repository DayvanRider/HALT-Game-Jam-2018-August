extends KinematicBody2D
#constants
const SPEED = 150
const UP = Vector2(0,-1)
const JUMP = -250
export(int) var GRAVITY = 10
const WALLJUMPPAR = 1.1
const JUMPS = 2
const LURPVAL = 0.7

var motion = Vector2(0,0)
var lastKey
#count walljumps
var noJumps = 0



func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
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
		
	#no left or right keystroke
	elif is_on_floor():
		motion.x = 0
		#reset noJumps 
		noJumps = 0
		
	#Jump
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
		
	
	#if character is on wall
	if is_on_wall() && !is_on_floor() && noJumps < JUMPS:
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
			noJumps += 1
	
	#only update motion if character is on the ground 
	var motiontmp = move_and_slide(motion,UP)
	if is_on_floor():
		motion = motiontmp
	if !is_on_wall():
		motion.x = lerp(0,motion.x,LURPVAL)
		
	
