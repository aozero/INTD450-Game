extends Area

onready var DIALOGUE = get_node("/root/Dialogue").TUTORIAL_2
var activated = false

func _on_Tutorial_2_body_entered(body):
	if !activated && body.get_class() == "Player":
		body.play_dialogue(DIALOGUE)
		
		activated = true
