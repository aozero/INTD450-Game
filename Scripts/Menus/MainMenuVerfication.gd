extends Control

onready var click_audio = $ClickAudio
onready var globals = get_node("/root/Globals")
onready var music_player = get_node("/root/MusicPlayer")

func _on_YesButton_button_up():
	globals.in_memory = false
	globals.noodle_boi_activated = [false, false, false]
	globals.tree_ind = 0              
	globals.tree_nums = [0, 0, 0, 0]
	globals.fire_ind = 0
	music_player.stop_drone()
	music_player.stop_melody()
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")

func _on_NoButton_button_up():
	click_audio.play()
	visible = false
