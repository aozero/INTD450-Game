extends AudioStreamPlayer3D

onready var timer = $Timer

func _ready():
	timer.start()

func _on_Timer_timeout():
	translation.x = rand_range(-1,1)
	translation.z = rand_range(-1,1)
	play()

func _on_ForestNoisesAudio_finished():
	timer.start()
