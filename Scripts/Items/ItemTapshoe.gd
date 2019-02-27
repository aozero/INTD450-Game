extends "res://Scripts/Interactable.gd"

onready var music_player = $MusicPlayer

func _on_Timer_timeout():
	music_player.play()
