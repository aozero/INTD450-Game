extends StaticBody

onready var sprite = $CollisionShape/Spatial/Sprite3D

export var on = false

func _ready():
	sprite.visible = on
	
	if on:
		# If on, use a different layer so the match doesn't add to the brightness of the fire
		sprite.layers = 524288
	else:
		# If off, use normal layer
		sprite.layers = 1
