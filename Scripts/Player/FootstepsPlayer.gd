extends AudioStreamPlayer

# Handles playing cycled footstep sounds
# footstep is called by an animation Call Func Track

# If you change anything here, you will likely also want to change Monster/FootstepsMonster
# Unfortunately, they can't inherit from the same source because AudioStreamPlayer3D can't inherit from AudioStreamPlayer

var index = 0 
var step_array = ["1","2","3","4","5","6"]

func _ready(): 
	shuffle_array()

func get_step_stream():
	return load("res://Sound/Effects/Walking/walking_step" + step_array[index] + ".wav")

# We always play each sound once in a cycle, but the order of them playing changes
func footstep():
	stream = get_step_stream()
	play()
	
	index += 1
	if index >= step_array.size():
		index = 0
		shuffle_array()

# https://godotengine.org/qa/20003/how-to-generarting-random-no-repeat-numbers-in-array
func shuffle_array():
	for i in range(step_array.size()):
		var swap_val = step_array[i]
		var swap_idx = int(rand_range(i, step_array.size()))
		
		step_array[i] = step_array[swap_idx]
		step_array[swap_idx] = swap_val