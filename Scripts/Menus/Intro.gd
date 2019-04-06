extends ColorRect

const LINE_SPACING = 15

onready var line_1 = $Left/Line1
onready var line_2 = $Right/Line2
onready var line_3 = $Left/Line3
onready var line_4 = $Right/Line4
onready var line_5 = $Right/Line5
onready var line_6 = $Left/Line6
onready var line_7 = $Right/Line7
onready var line_8 = $Right/Line8

onready var animation_player = $AnimationPlayer
onready var music_player = get_node("/root/MusicPlayer")
onready var dialogue = get_node("/root/Dialogue")
onready var globals = get_node("/root/Globals")

const NUM_ANIMS = 8 # total number of animations to play
const START_MUSIC = 3  # which animation to start playing the music at
var curr_anim = 1

func _ready():
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
	
	line_2.rect_position.y = line_1.rect_position.y + line_1.rect_size.y + LINE_SPACING
	line_3.rect_position.y = line_2.rect_position.y + line_2.rect_size.y + LINE_SPACING
	line_4.rect_position.y = line_3.rect_position.y + line_3.rect_size.y + LINE_SPACING
	line_5.rect_position.y = line_4.rect_position.y + line_4.rect_size.y + LINE_SPACING
	line_6.rect_position.y = line_5.rect_position.y + line_5.rect_size.y + LINE_SPACING
	line_7.rect_position.y = line_6.rect_position.y + line_6.rect_size.y + LINE_SPACING
	line_8.rect_position.y = line_7.rect_position.y + line_7.rect_size.y + LINE_SPACING

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
