extends KinematicBody2D


#constants
const SPEED = 150
const UP = Vector2(0,-1)
export (int) var  JUMP = -250
export(int) var GRAVITY = 100
const WALLJUMPPAR = 1.2
const JUMPS = 10
const LURPVAL = 0.7
const GRACEFACTOR = 5
const WALLGRACEFACTOR = 10
#for protection against repeat walljump
const JUMPTIME = 0.4

#motion vector
var motion = Vector2(0,0)
#variabke for last keystroke
var lastKey
#count walljumps
var noJumps = 0
#variable for grace Period
var grace = 0
var wallgrace = 0
#variable for timer
var timernode = null
#variable for allowing movement
var left =  true
var right = true



func _ready():
	pass
	
func _physics_process(delta):
	#Add gravity
	motion.y += GRAVITY
	
	#left and right movement
	if Input.is_action_pressed("ui_right") && right == true:
		motion.x = SPEED
		#keep track of last keystroke
		lastKey = 1
	elif Input.is_action_pressed("ui_left") && left == true:
		motion.x = -SPEED
		#keep track of last keystroke
		lastKey = 2
	elif is_on_floor():
		motion.x = 0
		#reset noJumps 
		noJumps = 0
		
	#Jump
	if is_on_floor() || grace < GRACEFACTOR:
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
		
	#if character is on wall
	if (is_on_wall() && !is_on_floor()) || wallgrace <= WALLGRACEFACTOR:
		if is_on_wall():
			wallgrace = 0
			if motion.y >0:
				motion.y = motion.y * 0.5
		else:
			wallgrace += 1
		#slow down gravity 
		#TODO make modular

		#make walljump by pressing up
		if Input.is_action_just_pressed("ui_up"):
			#determine wall by last keystroke
			if (lastKey == 1 && wallgrace == 0) || (lastKey == 2 && wallgrace != 0):
				motion.y = WALLJUMPPAR*JUMP
				motion.x = -SPEED*1.5
				JumptimerRight()
			if (lastKey == 2 && wallgrace == 0) || (lastKey == 1 && wallgrace != 0):
				motion.y = WALLJUMPPAR*JUMP
				motion.x = SPEED*1.5
				JumptimerLeft()
			noJumps += 1
	
	#only update motion if character is on the ground 
	var motiontmp = move_and_slide(motion,UP)
	if is_on_floor():
		motion = motiontmp
		grace = 0
	#graze period
	else:
		motion.y = motiontmp.y
		grace += 1
	if !is_on_wall():
		motion.x = lerp(0,motion.x,LURPVAL)
		
		
func get_name():
	return "Player"			#Check for the Gem if Object is Player
	
	
	
	
		
		
func JumptimerLeft():
	timernode = get_node("Timer")
	timernode.set_wait_time(JUMPTIME)
	timernode.set_one_shot(true)
	timernode.connect("timeout", self, "setJumpFlagLeft")
	left = false
	timernode.start()

func JumptimerRight():
	timernode = get_node("Timer")
	timernode.set_wait_time(JUMPTIME)
	timernode.set_one_shot(true)
	timernode.connect("timeout", self, "setJumpFlagRight")
	right = false
	timernode.start()
	

func setJumpFlagLeft():
	left = true
	
func setJumpFlagRight():
	right = true
	
