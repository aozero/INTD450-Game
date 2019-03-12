extends "res://Scripts/Items/Final Item.gd"

func _ready():
	MUSIC = load("res://Sound/Music/KitchenMemory.wav")

func interact(player):
	get_tree().change_scene("res://Scenes/Worlds/Study.tscn")
