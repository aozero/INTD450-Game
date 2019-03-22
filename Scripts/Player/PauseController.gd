extends Node

# Separate from player because player must stop working during pause but this must always be working            
onready var pause_menu_rect = $PauseMenuRect
onready var options_menu_rect = $OptionsMenuRect

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if event.is_action_pressed("pause"):
		set_paused(!get_tree().paused)

func set_paused(paused):
	get_tree().paused = paused
	
	pause_menu_rect.visible = paused
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_ExitButton_button_up():
	get_tree().quit()

func _on_ResumeButton_button_up():
	set_paused(false)

func _on_OptionsButton_button_up():
	options_menu_rect.visible = true
