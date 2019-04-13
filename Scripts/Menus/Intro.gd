extends ColorRect

const LINE_SPACING = 20
const LINE_SPACING_SPANISH = 10
const LINE_SPACING_FRENCH = 5

onready var resizer_1 = $Left/resizer1
onready var resizer_2 = $Right/resizer2
onready var resizer_3 = $Left/resizer3
onready var resizer_4 = $Right/resizer4
onready var resizer_5 = $Right/resizer5
onready var resizer_6 = $Left/resizer6
onready var resizer_7 = $Right/resizer7
onready var resizer_8 = $Right/resizer8

onready var line_1 = $Left/resizer1/Line1
onready var line_2 = $Right/resizer2/Line2
onready var line_3 = $Left/resizer3/Line3
onready var line_4 = $Right/resizer4/Line4
onready var line_5 = $Right/resizer5/Line5
onready var line_6 = $Left/resizer6/Line6
onready var line_7 = $Right/resizer7/Line7
onready var line_8 = $Right/resizer8/Line8

onready var animation_player = $AnimationPlayer
onready var music_player = get_node("/root/MusicPlayer")
onready var dialogue = get_node("/root/Dialogue")
onready var globals = get_node("/root/Globals")

const NUM_ANIMS = 8 # total number of animations to play
const START_MUSIC = 3  # which animation to start playing the music at
var curr_anim = 1

var line_spacing = LINE_SPACING

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	music_player.stop_drone()
	animation_player.play("1")
	
	line_1.text = dialogue.get_subtitles(dialogue.INTRO_1)
	line_2.text = dialogue.get_subtitles(dialogue.INTRO_2)
	line_3.text = dialogue.get_subtitles(dialogue.INTRO_3)
	line_4.text = dialogue.get_subtitles(dialogue.INTRO_4)
	line_5.text = dialogue.get_subtitles(dialogue.INTRO_5)
	line_6.text = dialogue.get_subtitles(dialogue.INTRO_6)
	line_7.text = dialogue.get_subtitles(dialogue.INTRO_7)
	line_8.text = dialogue.get_subtitles(dialogue.INTRO_8)
	
	if dialogue.SUBTITLES_SUPPORTED[dialogue.subtitles_language] == "Français":
		line_spacing = LINE_SPACING_FRENCH
	elif dialogue.SUBTITLES_SUPPORTED[dialogue.subtitles_language] == "Español":
		line_spacing = LINE_SPACING_SPANISH

func _process(delta):	
	# Labels don't resize until it starts really running (so here, in _process)
	# Also the sizing of things changes when made visible/not visible so we just just constantly
	resizer_2.rect_position.y = resizer_1.rect_position.y + resizer_1.rect_size.y + line_spacing
	resizer_3.rect_position.y = resizer_2.rect_position.y + resizer_2.rect_size.y + line_spacing
	resizer_4.rect_position.y = resizer_3.rect_position.y + resizer_3.rect_size.y + line_spacing
	resizer_5.rect_position.y = resizer_4.rect_position.y + resizer_4.rect_size.y + line_spacing
	resizer_6.rect_position.y = resizer_5.rect_position.y + resizer_5.rect_size.y + line_spacing
	resizer_7.rect_position.y = resizer_6.rect_position.y + resizer_6.rect_size.y + line_spacing
	resizer_8.rect_position.y = resizer_7.rect_position.y + resizer_7.rect_size.y + line_spacing

func _input(event):
	if event.is_action_pressed("pause"):
		music_player.fade_in(music_player.drone_player)
		start_game()

func _on_AnimationPlayer_animation_finished(anim_name):
	if curr_anim < NUM_ANIMS:
		curr_anim += 1
		animation_player.play(String(curr_anim))
		if curr_anim == START_MUSIC:
			music_player.start_drone_intro()
	else:
		start_game()

func start_game():
	get_tree().change_scene("res://Scenes/Worlds/Kitchen.tscn")
