extends "res://Scripts/Items/Final Item.gd"

func _ready():
	DIALOGUE = get_node("/root/Dialogue").STUDY_FINAL

func after_memory():
	get_tree().change_scene("res://Scenes/Worlds/Bedroom.tscn")
	
	.after_memory()
