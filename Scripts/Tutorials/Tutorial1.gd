extends Area

onready var DIALOGUE = get_node("/root/Dialogue").TUTORIAL_1
var activated = false

func _on_Tutorial_1_body_entered(body):
	if !activated && body.get_class() == "Player":
		body.play_dialogue(DIALOGUE)
		
		activated = true
