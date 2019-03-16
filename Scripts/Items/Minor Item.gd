extends KinematicBody

var DIALOGUE # Container with TEXT, SOUND, and LENGTH. Set by inherting classes

func interact(player):
	player.start_minor_memory(DIALOGUE.SOUND, DIALOGUE.TEXT, DIALOGUE.LENGTH)
