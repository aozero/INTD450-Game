extends ColorRect

onready var sprite_anim = $CanvasLayer/SpriteContainer/Sprite/AnimationPlayer
onready var options_menu = $CanvasLayer2/OptionsMenu
onready var exit_verification = $CanvasLayer2/ExitVerfication
onready var canvaslayer_1 = $CanvasLayer
onready var canvaslayer_2 = $CanvasLayer2
onready var timer = $Timer

onready var fire_audio = $FireAudio
onready var mainmenu_music = $MainMenuMusic
onready var blowout_audio = $BlowoutAudio
onready var click_audio = $ClickAudio

func _ready():
	sprite_anim.play("loop")

func _on_StartButton_button_up():
	color = Color(0, 0, 0)
	canvaslayer_1.layer = -1
	canvaslayer_2.layer = -1
	fire_audio.stop()
	mainmenu_music.stop()
	blowout_audio.play()
	timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Intro.tscn")

func _on_BrightnessButton_button_up():
	click_audio.play()
	get_tree().change_scene("res://Scenes/Menus/GammaChanger.tscn")

func _on_OptionsButton_button_up():
	click_audio.play()
	options_menu.visible = true

func _on_ExitButton_button_up():
	click_audio.play()
	exit_verification.visible = true
