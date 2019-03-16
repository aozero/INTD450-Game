extends "res://Scripts/Items/Final Item.gd"

func _ready():
	DIALOGUE = get_node("/root/Dialogue").STUDY_FINAL

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
