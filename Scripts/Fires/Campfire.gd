extends StaticBody

onready var sprite = $CollisionShape/Spatial/Sprite3D
onready var light = $CollisionShape/Spatial/Sprite3D/FireLight

export var on = false

func _ready():
	light.visible = on
