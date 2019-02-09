extends KinematicBody

# Return "Interactable" instead of "KinematicBody" 
# This is so we can check if an object is an interactable
func get_class():
	return "Interactable"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func interact(player):
	player.anim_player.play("Fade To White")
	kill()

func kill():
	queue_free()