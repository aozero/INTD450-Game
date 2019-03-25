extends Spatial

onready var brightness_slider = $CanvasLayer/BrightnessContainer/BrightnessSlider
onready var contrast_slider = $CanvasLayer/ContrastContainer/ContrastSlider
onready var globals = get_node("/root/Globals")

func _ready():
	brightness_slider.value = globals.get_brightness()
	contrast_slider.value = globals.get_contrast()

func _input(event):
	if event.is_action_pressed("pause"):
		done()

func _on_Brightness_value_changed(value):
	globals.set_brightness(value)

func _on_ContrastSlider_value_changed(value):
	globals.set_contrast(value)

func _on_DoneButton_button_up():
	done()

func done():
	get_tree().change_scene("res://Scenes/Intro.tscn")
