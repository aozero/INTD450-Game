extends Sprite3D

onready var anim_player = $AnimationPlayer

func _ready():
	var globals = get_node("/root/Globals")
	
	anim_player.play("loop")
	
	# We don't want the fires to all start at the same time and be identical
	# Instead of doing it randomly, cycle through a repeating distribution of fire start times
	var start_time = globals.fire_start_array[globals.fire_ind % globals.fire_start_array.size()]
	start_time += rand_range(-0.05, 0.05)
	globals.fire_ind += 1
	anim_player.seek(start_time)