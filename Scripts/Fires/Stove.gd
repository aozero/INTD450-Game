extends StaticBody

onready var sprite = $CollisionShape/Spatial/Sprite3D
onready var light = $CollisionShape/Spatial/Sprite3D/Light

export var on = false

func _ready():
	light.visible = on
	if on:
		sprite.frame = 1
		sprite.material_override = load("res://Materials/UnshadedBillboard.tres")
	else:
		sprite.frame = 0
		sprite.material_override = load("res://Materials/Billboard.tres")
