extends Node

# Separate from player because player must stop working during pause but this must always be working        
    
onready var pause_menu_rect = $PauseMenuRect
onready var options_menu = $OptionsMenu
onready var exit_verify = $ExitVerfication
onready var click_audio = $ClickAudio

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):	
	if event.is_action_pressed("pause"):
		set_paused(!get_tree().paused)

# If player alt-tabs or we otherwise lose focus, pause the game
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		set_paused(true)

func set_paused(paused):
	get_tree().paused = paused
	
	pause_menu_rect.visible = paused
	options_menu.visible = false
	exit_verify.visible = false
	
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_ExitButton_button_up():
	click_audio.play()
	exit_verify.visible = true

func _on_ResumeButton_button_up():
	click_audio.play()
	set_paused(false)

func _on_OptionsButton_button_up():
	click_audio.play()
	options_menu.visible = true
