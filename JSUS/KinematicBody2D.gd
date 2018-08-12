extends KinematicBody2D


#constants
#Movement Speed
export (int) var SPEED = 150
const UP = Vector2(0,-1)
#JUMP strength
export (int) var  JUMP = -250
#Gravity
export(int) var GRAVITY = 100
#Walljumpstrength
export (float) var WALLJUMPPAR = 1.2
#Lurpvalue
export (float) var LURPVAL = 0.7
#gracevalue in frames
export (int) var GRACEFACTOR = 5
#gracevalue for walljumps 
export (int) var WALLGRACEFACTOR = 10
#make Boostvalue that will be added to counteract climbing
export (int) var MAXWALLJUMPBOOST = 280
#will be subtracted from the walljumpboost each frame
export (int) var WALLJUMPBOOSTITERATOR = 7





#motion vector
var motion = Vector2(0,0)
#variabke for last keystroke
var lastKey
#count walljumps
var noJumps = 0
#variable for grace Period
var grace = 0
var wallgrace = 0
var walljumpboost = 0





func _ready():
	pass
	
	
func _physics_process(delta):
	#Add gravity
	motion.y += GRAVITY
	#left and right and down movement tracking
	basicMovement()

	#Jump tracking
	jumping()

		
	#walljumptracking
	wallJumpTracking()
	#make walljumps non climbeable
	climbProtection()
	
	#call move and slide and update motion and grace values
	#also add lurp
	moveAndUpdate()

	
	

		
		
func get_name():
	return "Player"			#Check for the Gem if Object is Player
	
func basicMovement():
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = true
		#keep track of last keystroke
		lastKey = 1
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = false
		#keep track of last keystroke
		lastKey = 2
	elif Input.is_action_pressed("ui_down") && is_on_wall():
		motion.x = 0
	elif is_on_floor():
		motion.x = 0
		walljumpboost = 0
		
		
func jumping():
	if is_on_floor() || grace < GRACEFACTOR:
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
	
func wallJumpTracking():
	if (is_on_wall() && !is_on_floor()) || wallgrace <= WALLGRACEFACTOR:
		if is_on_wall():
			wallgrace = 0
			if motion.y >0 && (Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left")):
				motion.y = motion.y * 0.5
		else:
			wallgrace += 1

		#make walljump by pressing up
		if Input.is_action_just_pressed("ui_up"):
			#determine wall by last keystroke
			if (lastKey == 1 && wallgrace == 0) || (lastKey == 2 && wallgrace != 0):
				motion.y = WALLJUMPPAR*JUMP
				walljumpboost = -MAXWALLJUMPBOOST
				motion.x = 1
				#JumptimerRight()
			if (lastKey == 2 && wallgrace == 0) || (lastKey == 1 && wallgrace != 0):
				motion.y = WALLJUMPPAR*JUMP
				walljumpboost = MAXWALLJUMPBOOST
				motion.x = -1
				#JumptimerLeft()
				
func climbProtection():
	if abs(walljumpboost) > WALLJUMPBOOSTITERATOR:
			
		if walljumpboost > 0:
			if motion.x <= 0:
				motion.x += walljumpboost
				
			walljumpboost -= WALLJUMPBOOSTITERATOR
		if walljumpboost < 0:
			if motion.x >= 0:
				motion.x += walljumpboost
				
			walljumpboost += WALLJUMPBOOSTITERATOR
			
			
func moveAndUpdate():
	#only update motion if character is on the ground 
	var motiontmp = move_and_slide(motion,UP)
	if is_on_floor():
		motion = motiontmp
		grace = 0
	else:
		motion.y = motiontmp.y
		grace += 1
	if !is_on_wall():
		motion.x = lerp(0,motion.x,LURPVAL)
