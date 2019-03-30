extends StaticBody

onready var sprite = $CollisionShape/Spatial/Sprite3D
onready var light = $CollisionShape/Spatial/Sprite3D/FireLight

export var on = false

func _ready():
	light.visible = on
	
	if on:
		sprite.frame = 1
		# If on, use a different layer so the match doesn't add to the brightness of the fire
		sprite.layers = 524288
	else:
		sprite.frame = 0
		# If off, use normal layer
		sprite.layers = 1
