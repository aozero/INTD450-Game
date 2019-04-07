extends ColorRect

# GENERAL
onready var mouse_sens_slider = $VBoxContainer/Tabs/General/Right/Sensitivity/SensitivitySlider
onready var fullscreen_box = $VBoxContainer/Tabs/General/Right/Fullscreen/FullscreenBox

# DISPLAY
onready var brightness_slider = $VBoxContainer/Tabs/Display/Right/Brightness/BrightnessSlider
onready var contrast_slider = $VBoxContainer/Tabs/Display/Right/Contrast/ContrastSlider
onready var shadow_box = $VBoxContainer/Tabs/Display/Right/Shadows/ShadowBox
onready var quality_button = $VBoxContainer/Tabs/Display/Right/ForestQuality/QualityButton
onready var quantity_button = $VBoxContainer/Tabs/Display/Right/ForestQuantity/QuantityButton

# AUDIO
onready var master_slider = $VBoxContainer/Tabs/Audio/Right/Master/MasterSlider
onready var music_slider = $VBoxContainer/Tabs/Audio/Right/Music/MusicSlider
onready var effects_slider = $VBoxContainer/Tabs/Audio/Right/Effects/EffectsSlider
onready var voice_slider = $VBoxContainer/Tabs/Audio/Right/Voice/VoiceSlider
onready var subtitles_button = $VBoxContainer/Tabs/General/Right/Subtitles/SubtitlesButton

onready var back_button = $VBoxContainer/BackContainer/BackButton
onready var click_audio = $ClickAudio
onready var click_audio_music = $ClickAudioMusic
onready var click_audio_effects = $ClickAudioEffects
onready var click_audio_voice = $ClickAudioVoice
onready var dialogue = get_node("/root/Dialogue")
onready var globals = get_node("/root/Globals")

func _ready():
	for i in dialogue.SUBTITLES_SUPPORTED:
		subtitles_button.add_item(i)

func _on_OptionsMenu_visibility_changed():
	mouse_sens_slider.value = globals.get_mouse_sens()
	fullscreen_box.pressed = globals.get_fullscreen()
	
	brightness_slider.value = globals.get_brightness()
	contrast_slider.value = globals.get_contrast()
	shadow_box.pressed = globals.get_shadows()
	quality_button.select(globals.get_forest_quality())
	quantity_button.select(globals.get_forest_quantity())
	
	master_slider.value = get_volume("Master")
	music_slider.value = get_volume("Music")
	effects_slider.value = get_volume("Effects")
	voice_slider.value = get_volume("Voice")
	subtitles_button.select(dialogue.get_subtitles_language())

func _on_Tabs_tab_changed(tab):
	click_audio.play()

func _on_BackButton_button_up():
	click_audio.play()
	visible = false

func _on_SensitivitySlider_value_changed(value):
	click_audio.play()
	globals.set_mouse_sens(value)

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

func _on_QuantityButton_item_selected(ID):
	click_audio.play()
	globals.set_forest_quantity(ID)

func _on_ShadowBox_button_up():
	click_audio.play()
	# is_pressed returns true when the check mark is not there
	globals.set_shadows(!shadow_box.is_pressed())

# Bus is a string with the name of the bus
func get_volume(bus):
	# convert from db to linear slider value
	var result = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus)))
	return result

# Bus is a string with the name of the bus
func set_volume(bus, value):
	# convert from linear slider value to db
	value = linear2db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), value)

func _on_MasterSlider_value_changed(value):
	set_volume("Master", value)
	click_audio.play()

func _on_MusicSlider_value_changed(value):
	set_volume("Music", value)
	click_audio_music.play()

func _on_EffectsSlider_value_changed(value):
	set_volume("Effects", value)
	click_audio_effects.play()

func _on_VoiceSlider_value_changed(value):
	set_volume("Voice", value)
	set_volume("Voice Super Echo", value)
	set_volume("Voice No Reverb", value)
	click_audio_voice.play()

func _on_SubtitlesButton_item_selected(ID):
	click_audio.play()
	dialogue.set_subtitles_language(ID)
