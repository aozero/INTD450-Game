extends KinematicBody

var MUSIC # Set by child scripts

onready var anim_player = $AnimationPlayer
onready var music_player = $MusicPlayer

var interacted_with = false

func interact(player):
	if !interacted_with:
		anim_player.play("Fade Out")
		player.start_tapshoe_memory(MUSIC)
		interacted_with = true

func _on_Timer_timeout():
	music_player.play()

func kill():
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade Out":
		kill()