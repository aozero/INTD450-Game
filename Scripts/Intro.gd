extends ColorRect

onready var animation_player = $AnimationPlayer
onready var music_player = get_node("/root/MusicPlayer")

const NUM_ANIMS = 8 # total number of animations to play
const START_MUSIC = 3  # which animation to start playing the music at
var curr_anim = 1

func _ready():
	music_player.stop_drone()
	animation_player.play("1")

func _on_AnimationPlayer_animation_finished(anim_name):
	if curr_anim < NUM_ANIMS:
		curr_anim += 1
		animation_player.play(String(curr_anim))
		if curr_anim == START_MUSIC:
			music_player.start_drone_intro()
	else:
		get_tree().change_scene("res://Scenes/Worlds/Kitchen.tscn")
