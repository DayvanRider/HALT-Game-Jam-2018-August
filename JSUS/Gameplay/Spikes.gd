extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(float) var RestingTime = 1				#Time the spike stays hidden 
export(float) var ActiveTime	= 2				#Time the spike stays active
export(bool) var Static = false				#If spikes are static or moving
export(float) var Speed = 1						#speed of movement phase
export(String, "up", "down", "left", "right") var Direction = "up"			#Movement direction of spikes



var MovementPhase				#to keep track of movement phase
var StateTime = 0				#counts for how long the state has been active for

var Movement = Vector2(0,0)		#local var for direction
var MotionSteps = 0				#how much it has moved from origin
var NextFramePosition = Vector2(0,0)


var OriginalPosition
var RestPosition = Vector2(0,0)



func _ready():
	set_draw_behind_parent(true) 
	OriginalPosition = get_global_position()
	match Direction:			#set direction of tile movement
		"up":			#Movement of moving out:
			Movement.x = 0
			Movement.y = Speed
			RestPosition.x = OriginalPosition.x
			RestPosition.y = OriginalPosition.y + 16

		"down":
			get_node("Sprite").set_rotation_degrees(180)
			Movement.x = 0
			Movement.y = -Speed
			RestPosition.x = OriginalPosition.x
			RestPosition.y = OriginalPosition.y - 16

		"right":
			get_node("Sprite").set_rotation_degrees(90)
			Movement.x = -Speed
			Movement.y = 0
			RestPosition.x = OriginalPosition.x - 16
			RestPosition.y = OriginalPosition.y

		"left":
			get_node("Sprite").set_rotation_degrees(270)
			Movement.x = Speed
			Movement.y = 0
			RestPosition.x = OriginalPosition.x + 16
			RestPosition.y = OriginalPosition.y

	MotionSteps = 0
	MovementPhase = 0
	pass





func _physics_process(delta):
	
	
	
	match MovementPhase:
			0:			#rest Active
				#print("Resting active")
				set_global_position(OriginalPosition)
				StateTime = StateTime + delta
				if StateTime > ActiveTime:
					MovementPhase += 1

			1:			#movement in
				#print("Moving in")
				NextFramePosition = get_global_position() + Movement
				set_global_position(NextFramePosition)
				StateTime = 0
				if get_global_position() == RestPosition:
					MovementPhase += 1

			2:			#rest hidden
				#print("Resting hidden")
				set_global_position(RestPosition)
				StateTime = StateTime + delta
				if StateTime > RestingTime:
					MovementPhase += 1

			3:			#movement out
				#print("Moving out")
				NextFramePosition = get_global_position() - Movement
				set_global_position(NextFramePosition)
				StateTime = 0
				if get_global_position() == OriginalPosition:
					MovementPhase = 0


