extends "res://Scripts/Multidirectional.gd"

# Script controlling the monsters
##################################
# How fast the monster can move
const NORMAL_SPEED = 1
const ALERTED_SPEED = 2

# How far the monster can see the player when player is dark or lit
const DETECT_DARK_WALK_RANGE = 4
const DETECT_LIT_WALK_RANGE = 8
const DETECT_DARK_RUN_RANGE = 8
const DETECT_LIT_RUN_RANGE = 12
##################################

onready var SOUND_BREATHING = load("res://Sound/Effects/Monster/brain_boi_breathing.wav") 
onready var SOUND_ALERTED = load("res://Sound/Effects/Monster/brain_boi_alerted.wav")

onready var detection_raycast = $RayCast
onready var audio_breathing = $AudioBreathing
onready var audio_walking = $AudioWalking

# for pathfinding
onready var navigation = get_tree().get_root().get_node("World/Navigation")
var player_pos = null
var path = []
var path_ind = 0

var patrol_waypoints = []
var patrol_ind = 0
# for pathfinding testing
onready var draw = get_tree().get_root().get_node("World/Draw")
var draw_path = false

var alerted = false
var curr_move_speed = NORMAL_SPEED

# Return "Monster" instead of "KinematicBody" 
# This is so we can check if an object is a monster
func get_class():
	return "Monster"

func _ready():
	add_to_group("monsters")
	stop_moving()
	
	process_child_waypoints()
	
	# Start breathing at some random interval so monster's aren't all breathing in sync
	audio_breathing.play(rand_range(0, 5))

# If we have waypoint objects as children, 
# Store their positions in an array and delete them (we only need their original position)
func process_child_waypoints():
	for c in get_children():
		if c.get_class() == "Waypoint":
			patrol_waypoints.append(c.pos)
			c.queue_free()
	
	if !patrol_waypoints.empty():
		path_to_point(patrol_waypoints[patrol_ind])
		start_moving()

func _physics_process(delta):
	if player == null:
		return
	
	# Set detection range based on player's state
	var detection_range
	if player.get_torch_visible() && player.running:
		detection_range = DETECT_LIT_RUN_RANGE
	elif player.get_torch_visible():
		detection_range = DETECT_LIT_WALK_RANGE
	elif player.running:
		detection_range = DETECT_DARK_RUN_RANGE
	else:
		detection_range = DETECT_DARK_WALK_RANGE
	
	var vec_to_player = player.global_transform.origin - global_transform.origin
	vec_to_player = vec_to_player.normalized()
	
	var see_player = false
	# Check if a ray to player within detection range can be cast
	detection_raycast.cast_to = vec_to_player * detection_range
	if detection_raycast.is_colliding(): 
		# Make sure what the ray is colliding with is actually the player
		var raycast_collider = detection_raycast.get_collider()
		if raycast_collider != null and raycast_collider.name == "Player":
			see_player = true
			if path.size() == 0:
				path_to_player() 
				start_moving()
			else:
				# Only set path again if the player's position has significantly changed
				if player_pos == null || player_pos.distance_to(player.translation) > 1:
					path_to_player() 
	
	if !alerted && see_player:
		start_alerted()
	elif alerted && !see_player:
		stop_alerted()
	
	# If we have waypoints stored and haven't seen the player yet, start patrolling between the points in order
	if !patrol_waypoints.empty() && player_pos == null && path.size() == 0:
		patrol_ind += 1
		if patrol_ind >= patrol_waypoints.size():
			patrol_ind = 0
		
		path_to_point(patrol_waypoints[patrol_ind])
		start_moving()
	
	# If we haven't finished the path yet
	if path_ind < path.size():
		var target_pos = get_curr_path_section_target_pos()
		
		var move_vec = (target_pos - global_transform.origin)
		if move_vec.length() < 0.1:
			path_ind += 1
		else:
			move_vec = move_vec.normalized()
			var collision = move_and_collide(move_vec * curr_move_speed * delta)
			if collision != null and collision.get_collider().get_class() == "Player":
				collision.get_collider().kill()
		
		# Look where we're going
		# We may have just finished a section of the path, so get the newest target_pos for looking
		target_pos = get_curr_path_section_target_pos()
		top_looker.look_at(target_pos, UP)
		
		# If that finished the path
		if path_ind >= path.size():
			stop_moving()

# Called when changing from idle to moving
func start_moving():
	anim_player.stop()
	anim_player.play("walk_0")
	audio_walking.play()
	update_sprite_direction()

# Called when changing from moving to idle
func stop_moving():
	path = []
	anim_player.stop()
	anim_player.play("idle_0")
	audio_walking.stop()
	update_sprite_direction()

func start_alerted():
	alerted = true
	curr_move_speed = ALERTED_SPEED
	anim_player.playback_speed = 1
	
	audio_breathing.set_stream(SOUND_ALERTED)
	audio_breathing.play()

func stop_alerted():
	alerted = false
	curr_move_speed = NORMAL_SPEED
	anim_player.playback_speed = float(NORMAL_SPEED) / ALERTED_SPEED
	
	audio_breathing.set_stream(SOUND_BREATHING)
	audio_breathing.play()

# slightly fuzzy position check
func is_at_pos(pos):
	return !(translation.x - pos.x > 0.1 || translation.y - pos.y > 0.1 || translation.z - pos.z > 0.1)

# Set a path to the player
func path_to_player():
	player_pos = player.global_transform.origin
	path_to_point(player_pos)

# Set a path to a point
func path_to_point(point):
	if navigation != null:		
		var begin = global_transform.origin
		var end = point
		
		var p = navigation.get_simple_path(begin, end)
		path = p
		path_ind = 0
		
		# debug pathfinding by drawing the monster's path.
		# if there are multiple paths they will flicker b/c they are all using the same draw object
		if (draw_path):
			var im = draw
			im.clear()
			im.begin(Mesh.PRIMITIVE_POINTS, null)
			im.add_vertex(begin)
			im.add_vertex(end)
			im.end()
			im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
			for x in p:
				im.add_vertex(x)
			im.end()

# Get the target position of the path subsection we are currently following
# Since the world is flat, we don't want to consider the y dimension
func get_curr_path_section_target_pos():
	var i = path_ind
	if path_ind >= path.size():
		# If path is finished, use end of path
		i = path.size() - 1
	
	var target_pos = path[i]
	target_pos.y = global_transform.origin.y
	return target_pos

func kill():
	remove_from_group("monsters")
	queue_free()