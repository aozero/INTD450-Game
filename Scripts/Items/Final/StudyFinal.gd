extends "res://Scripts/Items/Final Item.gd"

onready var MUSIC = load("res://Sound/Music/StudyMemory.wav")

func interact(player):
	.interact(player)
	player.start_tapshoe_memory(MUSIC)
