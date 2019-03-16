extends "res://Scripts/Items/Final Item.gd"

func _ready():
	MUSIC = load("res://Sound/Music/KitchenMemory.wav")
	SOUND = load("res://Sound/Effects/Memory/Final Items/bedroom_memory.wav")
	TEXT = get_node("/root/DialogueText").BEDROOM_FINAL

func after_memory():
	.after_memory()
