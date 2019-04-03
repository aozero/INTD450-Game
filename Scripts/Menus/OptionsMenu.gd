extends ColorRect

onready var fullscreen_box = $VBoxContainer/Tabs/Display/Right/Fullscreen/FullscreenBox
onready var brightness_slider = $VBoxContainer/Tabs/Display/Right/Brightness/BrightnessSlider
onready var quality_button = $VBoxContainer/Tabs/Display/Right/ForestQuality/QualityButton
onready var shadow_box = $VBoxContainer/Tabs/Display/Right/Shadows/ShadowBox
onready var back_button = $VBoxContainer/BackContainer/BackButton
onready var click_audio = $ClickAudio
onready var globals = get_node("/root/Globals")

func _ready():
	for i in globals.FOREST_QUALITY_TEXT:
		quality_button.add_item(i)

func _on_OptionsMenu_visibility_changed():
	fullscreen_box.pressed = globals.get_fullscreen()
	brightness_slider.value = globals.get_contrast()
	brightness_slider.value = globals.get_brightness()
	quality_button.select(globals.get_forest_quality())
	shadow_box.pressed = globals.get_shadows()

func _on_BackButton_button_up():
	click_audio.play()
	visible = false

func _on_FullscreenBox_button_up():
	click_audio.play()
	# is_pressed returns true when the check mark is not there
	globals.set_fullscreen(!fullscreen_box.is_pressed())

func _on_ContrastSlider_value_changed(value):
	click_audio.play()
	globals.set_contrast(value)

func _on_BrightnessSlider_value_changed(value):
	click_audio.play()
	globals.set_brightness(value)

func _on_QualityButton_button_up():
	click_audio.play()

func _on_QualityButton_item_selected(ID):
	click_audio.play()
	globals.set_forest_quality(ID)

func _on_ShadowBox_button_up():
	click_audio.play()
	# is_pressed returns true when the check mark is not there
	globals.set_shadows(!shadow_box.is_pressed())
