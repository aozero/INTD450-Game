extends Area

# An area around the player that turns Monster AI on/off when they enter/leave the area around the player
##################################

func _ready():
	# Connect signals to functions
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
func _on_body_entered(body):	
	if body.get_class() == "Monster":
		body.set_in_player_area(true)
	
func _on_body_exited(body):	
	if body.get_class() == "Monster":
		body.set_in_player_area(false)

