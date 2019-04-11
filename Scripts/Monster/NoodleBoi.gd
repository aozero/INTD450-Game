extends Sprite3D

# boi stands still until activated, then runs between waypoints and disappears
# Noodle boi only appears one time on each level, even if the play dies and comes back

const MOVE_SPEED = 5

onready var audio = $Audio

var waypoints = []
var way_ind = 0

var activated = false

func _ready():
	# Noodle boi only appears one time on each level, even if the play dies and comes back
	# activated is set in each child noodle bois script
	if activated:
		visible = false
	
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
	if !activated:
		audio.play()
		set_process(true)
		set_global_activation()

# Noodle boi only appears one time on each level, even if the play dies and comes back
# In child scripts, set the the correct variable in global to tell noodle boi to not appear again in that level
func set_global_activation():
	pass

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
