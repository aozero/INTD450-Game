extends Sprite3D

# boi stands still until activated, then runs between waypoints and disappears

const MOVE_SPEED = 5

onready var audio = $Audio

var waypoints = []
var way_ind = 0

var active = false

func _ready():
	set_process(false)
	process_child_waypoints()

# If we have waypoint objects as children, 
# Store their positions in an array and delete them (we only need their original position)
# Modified from Monster.gd. Inheritance would be difficult here and noodle boi is not that important
func process_child_waypoints():
	for c in get_children():
		if c.get_class() == "Waypoint":
			waypoints.append(c.pos)
			c.queue_free()

func activate():
	#audio.play()
	set_process(true)

func _process(delta):
	if way_ind < waypoints.size():
		var move_vec = waypoints[way_ind] - global_transform.origin 
		if move_vec.length() < 0.1:
			# Finished a section of the path
			way_ind += 1
		else:
			move_vec = move_vec.normalized()
			move_vec *= MOVE_SPEED * delta
			global_transform.origin += move_vec
	
