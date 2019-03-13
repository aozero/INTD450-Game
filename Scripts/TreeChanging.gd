extends StaticBody

onready var sprite = $CollisionShape/Sprite3D

func set_in_torch_area(value):
	print(value)
	if value:
		sprite.frame = 1
	else:
		sprite.frame = 0

