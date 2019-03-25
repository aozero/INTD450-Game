extends Camera

onready var globals = get_node("/root/Globals")

func _ready():
	add_to_group("cameras")
	set_brightness(globals.get_brightness())

func set_brightness(value):
	environment.adjustment_brightness = value
