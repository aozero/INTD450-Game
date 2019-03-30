extends OmniLight

onready var ground_light = $GroundLight
onready var globals = get_node("/root/Globals")

func _ready():
	add_to_group("lights")
	set_shadows(globals.get_shadows())
	
	# Light the ground differently - less powerfully, but longer distance
	ground_light.omni_range = omni_range
	ground_light.light_color = light_color
	ground_light.light_energy = light_energy / 3.0

func set_shadows(value):
	shadow_enabled = value
