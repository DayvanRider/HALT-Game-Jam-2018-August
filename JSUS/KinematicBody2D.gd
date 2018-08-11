extends KinematicBody2D
#constants
const SPEED = 300
const UP = Vector2(0,-1)
const JUMP = -500
export(int) var GRAVITY = 20

var motion = Vector2(0,0)



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
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	elif is_on_floor():
		motion.x = 0
		
	#Jump
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
		
	#if character is on wall
	if is_on_wall() && !is_on_floor():
		#slow down gravity 
		if motion.y >0:
			motion.y -= (GRAVITY/4) *2
		#make walljump by pressing up
		if Input.is_action_just_pressed("ui_up"):
			motion.y = 1.5*JUMP
			motion.x = SPEED
		
	var motiontmp = move_and_slide(motion,UP)
	if is_on_floor():
		motion = motiontmp
