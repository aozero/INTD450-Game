extends StaticBody

onready var globals = get_node("/root/Globals")

func _ready():
	add_to_group("extra forest")
	set_visible(globals.forest_quantity)

func set_visible(value):
	if value > 0:
		visible = true
	else:
		visible = false