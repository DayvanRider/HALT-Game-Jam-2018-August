extends Camera2D

const MAGNITUDE = 50
const SHAKETIME = 0.05
var currentpos = get_camera_position()

func _ready():
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_page_up"):
		shake()
	

func shake():
	var time = 0
	while time < SHAKETIME:
		var pos = Vector2()
		pos.x = rand_range(-MAGNITUDE,MAGNITUDE)
		pos.y = rand_range(-MAGNITUDE,MAGNITUDE)
		self.position = pos
		
		time += get_process_delta_time()
		
		yield(get_tree(),"idle_frame")
		
		self.position = currentpos
		yield(get_tree(),"idle_frame")
	self.position = currentpos
		
		
		
	
		
		
	
	
