extends ColorRect

# DISPLAY
onready var fullscreen_box = $VBoxContainer/Tabs/Display/Right/Fullscreen/FullscreenBox
onready var brightness_slider = $VBoxContainer/Tabs/Display/Right/Brightness/BrightnessSlider
onready var quality_button = $VBoxContainer/Tabs/Display/Right/ForestQuality/QualityButton
onready var shadow_box = $VBoxContainer/Tabs/Display/Right/Shadows/ShadowBox

# AUDIO
onready var master_slider = $VBoxContainer/Tabs/Audio/Right/Master/MasterSlider
onready var music_slider = $VBoxContainer/Tabs/Audio/Right/Music/MusicSlider
onready var effects_slider = $VBoxContainer/Tabs/Audio/Right/Effects/EffectsSlider
onready var voice_slider = $VBoxContainer/Tabs/Audio/Right/Voice/VoiceSlider

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
	
	master_slider.value = get_volume("Master")
	music_slider.value = get_volume("Music")
	effects_slider.value = get_volume("Effects")
	voice_slider.value = get_volume("Voice")

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

# Bus is a string with the name of the bus
func get_volume(bus):
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus))

# Bus is a string with the name of the bus
func set_volume(bus, value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), value)

func _on_MasterSlider_value_changed(value):
	set_volume("Master", value)

func _on_MusicSlider_value_changed(value):
	set_volume("Music", value)

func _on_EffectsSlider_value_changed(value):
	set_volume("Effects", value)

func _on_VoiceSlider_value_changed(value):
	set_volume("Voice", value)
