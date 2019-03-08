extends KinematicBody

onready var anim_player = $AnimationPlayer
onready var music_player = $MusicPlayer

func interact(player):
	anim_player.play("Fade Out")
	player.start_tapshoe_memory()

func _on_Timer_timeout():
	music_player.play()

func kill():
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade Out":
		kill()