extends ColorRect

onready var options_menu = $OptionsMenu
onready var exit_verification = $ExitVerfication

func _on_StartButton_button_up():
	get_tree().change_scene("res://Scenes/Menus/GammaChanger.tscn")

func _on_OptionsButton_button_up():
	options_menu.visible = true

func _on_ExitButton_button_up():
	exit_verification.visible = true


