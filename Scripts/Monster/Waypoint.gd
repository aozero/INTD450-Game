extends Spatial

onready var pos = global_transform.origin
export var wait_time = 2

func get_class():
	return "Waypoint"

func _ready():
	pass
