extends "res://Scripts/Items/Final Item.gd"

func _ready():
	MUSIC = load("res://Sound/Music/KitchenMemory.wav")
	SOUND = load("res://Sound/Effects/Memory/kitchen_memory.wav")
	TEXT = get_node("/root/DialogueText").KITCHEN_FINAL

func after_memory():
	get_tree().change_scene("res://Scenes/Worlds/Study.tscn")
	
	.after_memory()
