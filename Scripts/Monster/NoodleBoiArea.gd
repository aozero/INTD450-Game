extends Area

onready var noodle_boi = get_parent()

# When player enters this area, active noodle_boi


func _on_Area_body_entered(body):
	if body.get_class() == "Player":
		noodle_boi.activate()
