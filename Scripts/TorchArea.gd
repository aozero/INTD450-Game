extends Area

# An area around the player that signals to objects when they enter the range of the torch
##################################

func _ready():
	# Connect signals to functions
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
func _on_body_entered(body):	
	if body.has_method("set_in_torch_area"):
		body.set_in_torch_area(true)
	
func _on_body_exited(body):	
	if body.has_method("set_in_torch_area"):
		body.set_in_torch_area(false)
