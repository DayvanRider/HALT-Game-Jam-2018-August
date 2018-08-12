extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var HiddenTime = 1				#Time the spike stays hidden 
var ActiveTime	= 2				#Time the spike stays active
var Static = true				#If spikes are static or moving
var Speed						#speed of movement phase
var Direction = "up"			#Movement direction of spikes
								#possible: up, down, left, right


var MovementPhase				#to keep track of movement phase
var StateTime					#counts for how long the state has been active for

var Movement = Vector2(0,0)		#local var for direction
var MotionSteps = 0				#how much it has moved from origin

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	MotionSteps = 0
	MovementPhase = 0
	pass

func _physics_process(delta):
	if Static == true:
		match Direction:			#set direction of tile movement
			"up":
				Movement.y = Speed
				Movement.x = 0
			"down":
				Movement.y = -Speed
				Movement.x = 0
			"right":
				Movement.y = 0
				Movement.x = Speed
			"left":
				Movement.y = 0
				Movement.x = -Speed

		Movement()
		match MovementPhase:
			0:			#rest hidden
				StateTime = StateTime + delta
				if StateTime > HiddenTime:
					MovementPhase = 1
			1:			#movement out
				StateTime = 0
				move_and_slide(Movement)
				MotionSteps = Movement.y + Movement.x
				if 32 == abs(MotionSteps):
					MovementPhase = 2
					
			2:			#rest portruding
				StateTime = StateTime + delta
				if StateTime > ActiveTime:
					MovementPhase = 3
			3:			#movement in
				StateTime = 0
				move_and_slide(-1 * Movement)
				MotionSteps = Movement.y + Movement.x
				if 32 == abs(MotionSteps):
					MovementPhase = 0
				



















