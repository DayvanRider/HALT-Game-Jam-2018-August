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
	else:
		motion.x = 0
		
	#Jump
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
		
	#Walljump
	if is_on_wall():
		
		#reduce Gravity while on wall
		if motion.y > 0:
			motion.y -= GRAVITY/2
		if Input.is_action_just_pressed("ui_right"):
			motion.y = 3*JUMP
			motion.x = SPEED
		
		
	motion = move_and_slide(motion,UP)
	
	
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass