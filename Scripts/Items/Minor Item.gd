extends KinematicBody

var DIALOGUE # Container with TEXT, SOUND, and TEXT_TIME. Set by inherting classes

func interact(player):
	player.start_minor_memory(DIALOGUE)
