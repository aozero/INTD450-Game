extends AudioStreamPlayer3D

onready var timer = $Timer

# Played sound, wait
func _on_Noise_finished():
	stop()
	timer.start()

# Waited, play sound
func _on_Timer_timeout():
	start()
