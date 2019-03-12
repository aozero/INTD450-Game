extends "res://Scripts/Items/Final Item.gd"

func _ready():
	MUSIC = load("res://Sound/Music/KitchenMemory.wav")
	SOUND = load("res://Sound/Effects/Memory/bedroom_memory.wav")

func after_memory():
	.after_memory()
