extends StaticBody

onready var sprite = $CollisionShape/Spatial/Sprite3D

export var on = false

func _ready():
	sprite.visible = on
