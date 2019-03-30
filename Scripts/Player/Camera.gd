extends Camera

onready var globals = get_node("/root/Globals")

func _ready():
	add_to_group("cameras")
	set_brightness(globals.get_brightness())
	set_contrast(globals.get_contrast())

func set_brightness(value):
	environment.adjustment_brightness = value

func set_contrast(value):
	environment.adjustment_contrast = value
