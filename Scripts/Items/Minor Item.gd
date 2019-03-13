extends KinematicBody

var memory_text = ""

func interact(player):
	player.start_minor_memory(memory_text)
