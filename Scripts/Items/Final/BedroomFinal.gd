extends "res://Scripts/Items/Final Item.gd"

func _ready():
	DIALOGUE = get_node("/root/Dialogue").BEDROOM_FINAL
	BURN_ANIM_NAME = "burn bedroom"
	
	._ready()
	
	if burning:
		sprite.material_override = sprite.material_override.duplicate()
		sprite.material_override.flags_unshaded = true
		translation.y = 0.385

func after_memory():
	get_tree().change_scene("res://Scenes/Worlds/Finale.tscn")
	
	.after_memory()
