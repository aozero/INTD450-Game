extends Spatial

var sprite

func _ready():
	set_sprite()
	set_tree()

func set_sprite():
	sprite = $"."

func set_tree():
	var globals = get_node("/root/Globals")
	
	# Set sprite texture to a random tree in the sprite sheet
	#var sprite_index = int(rand_range(0, sprite.hframes))
	
	# Instead of doing it randomly, cycle through a repeating distribution of tree types
	var sprite_index = globals.tree_frame_array[globals.tree_ind % globals.tree_frame_array.size()]
	globals.tree_ind += 1
	
	# Count how many trees of each type we have (for debugging purposes)
	globals.tree_nums[sprite_index] += 1
	
	# Set tree sprite based on sprite_index
	sprite.frame = sprite_index
