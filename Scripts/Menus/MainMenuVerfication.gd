extends Control

onready var click_audio = $ClickAudio
onready var globals = get_node("/root/Globals")

func _on_YesButton_button_up():
	globals.return_to_main_menu()

func _on_NoButton_button_up():
	click_audio.play()
	visible = false
