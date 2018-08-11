extends Button

func _ready():
	self.connect("pressed", self, "_on_Button_pressed")
	
func _on_Button_pressed():
	get_tree().change_scene("level.tscn")