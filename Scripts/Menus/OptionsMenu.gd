extends ColorRect

onready var fullscreen_box = $VBoxContainer/Split/Right/Fullscreen/FullscreenBox
onready var brightness_slider = $VBoxContainer/Split/Right/Brightness/BrightnessSlider
onready var quality_button = $VBoxContainer/Split/Right/ForestQuality/QualityButton
onready var shadow_box = $VBoxContainer/Split/Right/Shadows/ShadowBox
onready var back_button = $VBoxContainer/BackContainer/BackButton
onready var globals = get_node("/root/Globals")

func _ready():
	for i in globals.FOREST_QUALITY_TEXT:
		quality_button.add_item(i)
	
	fullscreen_box.pressed = globals.get_fullscreen()
	brightness_slider.value = globals.get_contrast()
	brightness_slider.value = globals.get_brightness()
	quality_button.select(globals.get_forest_quality())
	shadow_box.pressed = globals.get_shadows()

func _on_BackButton_button_up():
	visible = false

func _on_FullscreenBox_button_up():
	# is_pressed returns true when the check mark is not there
	globals.set_fullscreen(!fullscreen_box.is_pressed())

func _on_ContrastSlider_value_changed(value):
	globals.set_contrast(value)

func _on_BrightnessSlider_value_changed(value):
	globals.set_brightness(value)

func _on_QualityButton_item_selected(ID):
	globals.set_forest_quality(ID)

func _on_ShadowBox_button_up():
	# is_pressed returns true when the check mark is not there
	globals.set_shadows(!shadow_box.is_pressed())




