extends KinematicBody

 # Set by child scripts
var DIALOGUE # Container with TEXT, SOUND, and MUSIC. Set by inherting classes

onready var anim_player = $AnimationPlayer
onready var music_player = $MusicPlayer
onready var sprite = $CollisionShape/Sprite3D

var interacted_with = false

func interact(player):
	if !interacted_with:
		anim_player.play("Fade Out")
		player.start_final_memory(self)
		interacted_with = true

# Called after the memory finished
# Override to do things like switch the scene
func after_memory():
	kill()

func _on_Timer_timeout():
	music_player.play()

func kill():
	queue_free()

# I can't disconnect the signal from the AnimationPlayer for some reason
# https://github.com/godotengine/godot/issues/12373
# So just catch it and ignore it
func _on_AnimationPlayer_animation_finished(anim_name):
	pass
