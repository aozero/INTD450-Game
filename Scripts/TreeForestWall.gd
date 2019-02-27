extends Spatial

func _ready():	
	# Set sprite texture to a random tree in the sprite sheet
	var sprite = $Sprite3D
	var rand_index = int(rand_range(0, sprite.hframes))
	sprite.frame = rand_index
	
