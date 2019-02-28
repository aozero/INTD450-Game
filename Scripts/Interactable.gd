extends KinematicBody

onready var anim_player = $AnimationPlayer

# Return "Interactable" instead of "KinematicBody" 
# This is so we can check if an object is an interactable
func get_class():
	return "Interactable"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func interact(player):
	anim_player.play("Fade Out")
	player.start_tapshoe_memory()

func kill():
	queue_free()

func _on_MusicPlayer_finished(anim_name):
	if anim_name == "Fade To Black":
		kill()
