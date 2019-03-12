extends KinematicBody

 # Set by child scripts
var MUSIC # Music to play during memory
var SOUND # Core audio content of memory

onready var anim_player = $AnimationPlayer
onready var music_player = $MusicPlayer
onready var sprite = $CollisionShape/Sprite3D

var interacted_with = false

func interact(player):
	if !interacted_with:
		anim_player.play("Fade Out")
		player.start_final_memory(self)
		interacted_with = true

func after_memory():
	kill()

func _on_Timer_timeout():
	music_player.play()

func kill():
	queue_free()
