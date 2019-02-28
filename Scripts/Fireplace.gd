extends StaticBody

onready var sprite = $CollisionShape/Spatial/Sprite3D

func turn_on():
	sprite.visible = true
