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
	ground_light.shadow_enabled = shadow_enabled
	ground_light.shadow_color = shadow_color
	ground_light.shadow_bias = shadow_bias
	ground_light.shadow_contact = shadow_contact
	ground_light.shadow_reverse_cull_face = shadow_reverse_cull_face

func set_shadows(value):
	shadow_enabled = value
	ground_light.shadow_enabled = value
