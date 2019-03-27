extends ColorRect

onready var sprite_anim = $CanvasLayer/SpriteContainer/Sprite/AnimationPlayer
onready var options_menu = $CanvasLayer2/OptionsMenu
onready var exit_verification = $CanvasLayer2/ExitVerfication
onready var canvaslayer_1 = $CanvasLayer
onready var canvaslayer_2 = $CanvasLayer2
onready var timer = $Timer

func _ready():
	sprite_anim.play("loop")

func _on_StartButton_button_up():
	color = Color(0, 0, 0)
	canvaslayer_1.layer = -1
	canvaslayer_2.layer = -1
	timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Menus/GammaChanger.tscn")

func _on_OptionsButton_button_up():
	options_menu.visible = true

func _on_ExitButton_button_up():
	exit_verification.visible = true
