extends AudioStreamPlayer3D

export var time_between_sounds = 5
onready var timer = $Timer

func _ready():
	if time_between_sounds > 0:
		timer.wait_time = time_between_sounds

# Played sound, wait
func _on_Noise_finished():
	stop()
	if time_between_sounds > 0:
		timer.start()
	else:
		play()

# Waited, play sound
func _on_Timer_timeout():
	play()
