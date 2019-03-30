extends "res://Scripts/Items/Final Item.gd"

func _ready():
	DIALOGUE = get_node("/root/Dialogue").KITCHEN_FINAL
	BURN_ANIM_NAME = "burn kitchen"
	._ready()

func after_memory():
	get_tree().change_scene("res://Scenes/Worlds/Study.tscn")
	
	.after_memory()
