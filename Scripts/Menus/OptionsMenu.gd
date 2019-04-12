extends ColorRect

# GENERAL
onready var fullscreen_lbl = $VBoxContainer/Tabs/General/Left/Fullscreen/FullscreenLabel
onready var fullscreen_box = $VBoxContainer/Tabs/General/Right/Fullscreen/FullscreenBox
const FULLSCREEN_TIP = "Toggle whether the game takes up the whole screen."

onready var mouse_sens_lbl = $VBoxContainer/Tabs/General/Left/Sensitivity/SensitivityLabel
onready var mouse_sens_slider = $VBoxContainer/Tabs/General/Right/Sensitivity/SensitivitySlider
const MOUSE_SENS_TIP = "Adjusts the speed of the mouse."

onready var subtitles_lbl = $VBoxContainer/Tabs/General/Left/Subtitles/SubtitlesLabel
onready var subtitles_button = $VBoxContainer/Tabs/General/Right/Subtitles/SubtitlesButton
const SUBTITLES_TIP = "What language the subtitles appear in.\n\"None\" means no subtitles for voiced dialogue."

# DISPLAY
onready var shadow_lbl = $VBoxContainer/Tabs/Display/Left/Shadows/ShadowLabel
onready var shadow_box = $VBoxContainer/Tabs/Display/Right/Shadows/ShadowBox
const SHADOW_TIP = "Toggles whether trees have shadows.\nCan make the game run slower."

onready var quality_lbl = $VBoxContainer/Tabs/Display/Left/ForestQuality/QualityLabel
onready var quality_button = $VBoxContainer/Tabs/Display/Right/ForestQuality/QualityButton
const QUALITY_TIP = "High makes trees look better.\nCan make the game run slower."

onready var quantity_lbl = $VBoxContainer/Tabs/Display/Left/ForestQuantity/QuantityLabel
onready var quantity_button = $VBoxContainer/Tabs/Display/Right/ForestQuantity/QuantityButton
const QUANTITY_TIP = "High adds more trees outside the path. Does not affect gameplay.\nCan make the game run slower."

onready var brightness_lbl = $VBoxContainer/Tabs/Display/Left/Brightness/BrightnessLabel
onready var brightness_slider = $VBoxContainer/Tabs/Display/Right/Brightness/BrightnessSlider
const BRIGHTNESS_TIP = "Adjusts brightness of screen."

onready var contrast_lbl = $VBoxContainer/Tabs/Display/Left/Contrast/ContrastLabel
onready var contrast_slider = $VBoxContainer/Tabs/Display/Right/Contrast/ContrastSlider
const CONTRAST_TIP = "Adjusts contrast of screen."

# AUDIO
onready var master_lbl = $VBoxContainer/Tabs/Audio/Left/Master/MasterLabel
onready var master_slider = $VBoxContainer/Tabs/Audio/Right/Master/MasterSlider
const MASTER_TIP = "Controls volume of the game."
onready var music_lbl = $VBoxContainer/Tabs/Audio/Left/Music/MusicLabel
onready var music_slider = $VBoxContainer/Tabs/Audio/Right/Music/MusicSlider
const MUSIC_TIP = "Controls volume of background music."
onready var effects_lbl = $VBoxContainer/Tabs/Audio/Left/Effects/EffectsLabel
onready var effects_slider = $VBoxContainer/Tabs/Audio/Right/Effects/EffectsSlider
const EFFECTS_TIP = "Controls volume of sound effects."
onready var voice_lbl = $VBoxContainer/Tabs/Audio/Left/Voice/VoiceLabel
onready var voice_slider = $VBoxContainer/Tabs/Audio/Right/Voice/VoiceSlider
const VOICE_TIP = "Controls volume of spoken dialogue."

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
	fullscreen_box.pressed = globals.get_fullscreen()
	mouse_sens_slider.value = globals.get_mouse_sens()
	subtitles_button.select(dialogue.get_subtitles_language())
	
	shadow_box.pressed = globals.get_shadows()
	quality_button.select(globals.get_forest_quality())
	quantity_button.select(globals.get_forest_quantity())
	brightness_slider.value = globals.get_brightness()
	contrast_slider.value = globals.get_contrast()
	
	master_slider.value = get_volume("Master")
	music_slider.value = get_volume("Music")
	effects_slider.value = get_volume("Effects")
	voice_slider.value = get_volume("Voice")
	
	fullscreen_lbl.hint_tooltip = FULLSCREEN_TIP
	fullscreen_box.hint_tooltip = FULLSCREEN_TIP
	mouse_sens_lbl.hint_tooltip = MOUSE_SENS_TIP
	mouse_sens_slider.hint_tooltip = MOUSE_SENS_TIP
	subtitles_lbl.hint_tooltip = SUBTITLES_TIP
	subtitles_button.hint_tooltip = SUBTITLES_TIP
	
	shadow_lbl.hint_tooltip = SHADOW_TIP
	shadow_box.hint_tooltip = SHADOW_TIP
	quality_lbl.hint_tooltip = QUALITY_TIP
	quality_button.hint_tooltip = QUALITY_TIP
	quantity_lbl.hint_tooltip = QUANTITY_TIP
	quantity_button.hint_tooltip = QUANTITY_TIP
	brightness_lbl.hint_tooltip = BRIGHTNESS_TIP
	brightness_slider.hint_tooltip = BRIGHTNESS_TIP
	contrast_lbl.hint_tooltip = CONTRAST_TIP
	contrast_slider.hint_tooltip = CONTRAST_TIP
	
	master_lbl.hint_tooltip = MASTER_TIP
	master_slider.hint_tooltip = MASTER_TIP
	music_lbl.hint_tooltip = MUSIC_TIP
	music_slider.hint_tooltip = MUSIC_TIP
	effects_lbl.hint_tooltip = EFFECTS_TIP
	effects_slider.hint_tooltip = EFFECTS_TIP
	voice_lbl.hint_tooltip = VOICE_TIP
	voice_slider.hint_tooltip = VOICE_TIP

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
