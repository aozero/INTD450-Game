extends StaticBody

onready var sprite = $CollisionShape/Spatial/Sprite3D
onready var light = $CollisionShape/Spatial/Sprite3D/FireLight
onready var stove_anim = $StoveAnim

export var on = false

func _ready():
	light.visible = on
	
	if on:
		stove_anim.play("lit")
		# If on, use a different layer so the match doesn't add to the brightness of the fire
		sprite.layers = 524288
	else:
		stove_anim.play("unlit")
		# If off, use normal layer
		sprite.layers = 1
