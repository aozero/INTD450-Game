extends "res://Scripts/Items/Final Item.gd"

func _ready():
	MUSIC = load("res://Sound/Music/StudyMemory.wav")
	SOUND = load("res://Sound/Effects/Memory/Final Items/study_memory.wav")
	TEXT = get_node("/root/DialogueText").STUDY_FINAL

func after_memory():
	# Unblock study path and turn on fireplace
	var blockedPath = get_tree().get_root().get_node("World/Navigation/NavigationMeshInstance/End Area/BlockedPath")
	if blockedPath != null:
		blockedPath.hide()
	var fireplace = get_tree().get_root().get_node("World/Navigation/NavigationMeshInstance/End Area/Fireplace")
	if fireplace != null:
		fireplace.turn_on()
	
	# TEMP Start countdown to close game
	get_tree().get_root().get_node("World/Player/Timer").start()
	
	.after_memory()
