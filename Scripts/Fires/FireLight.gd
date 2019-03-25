extends OmniLight

onready var globals = get_node("/root/Globals")

func _ready():
	add_to_group("lights")
	set_shadows(globals.get_shadows())

func set_shadows(value):
	shadow_enabled = value
