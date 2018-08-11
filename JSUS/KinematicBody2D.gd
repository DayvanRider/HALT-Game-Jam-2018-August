extends KinematicBody2D
#constants
const SPEED = 300
const UP = Vector2(0,-1)
const JUMP = -500
export(int) var GRAVITY = 20

var motion = Vector2(0,0)
var wallFlag = 0



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
	else:
		motion.x = 0
		
	#Jump
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
		#set flag for walljump to false
		wallFlag = 0
		
	#Set Flag if character is on wall
	if is_on_wall() && !is_on_floor():
		if motion.x < 0:
			wallFlag = 1
		if motion.x > 0:
			wallFlag = 2
		
			
	
		

	
	if wallFlag > 0:
		#TODO find out wich wall we are at
		#reduce Gravity while on wall
		if motion.y > 0:
			motion.y -= GRAVITY/2
		if wallFlag == 1:
			if Input.is_action_just_pressed("ui_right"):
				motion.y = 1.5*JUMP
				motion.x = SPEED
				wallFlag = 0
		if wallFlag == 2:
			if Input.is_action_just_pressed("ui_left"):
				motion.y = 1.5*JUMP
				motion.x = -SPEED
				wallFlag = 0
		
		
	motion = move_and_slide(motion,UP)
