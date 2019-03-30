extends Control

onready var click_audio = $ClickAudio

func _on_YesButton_button_up():
	get_tree().quit()

func _on_NoButton_button_up():
	click_audio.play()
	visible = false
