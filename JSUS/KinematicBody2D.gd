extends KinematicBody2D


#constants
const SPEED = 150
const UP = Vector2(0,-1)
export (int) var  JUMP = -250
export(int) var GRAVITY = 100
const WALLJUMPPAR = 1.2
const JUMPS = 10
const LURPVAL = 0.9
const GRACEFACTOR = 5
#for protection against repeat walljump
const JUMPTIME = 0.5

#motion vector
var motion = Vector2(0,0)
#variabke for last keystroke
var lastKey
#count walljumps
var noJumps = 0
#variable for grace Period
var grace = 0
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
				JumptimerRight()
			if lastKey == 2:
				motion.y = WALLJUMPPAR*JUMP
				motion.x = SPEED
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
	
