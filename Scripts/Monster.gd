extends "res://Scripts/Multidirectional.gd"

# Script controlling the monsters
##################################
# How fast the monster can move
const MOVE_SPEED = 2

# How far the monster can see the player when player is dark or lit
const DETECT_DARK_WALK_RANGE = 4
const DETECT_LIT_WALK_RANGE = 10
const DETECT_DARK_RUN_RANGE = 8
const DETECT_LIT_RUN_RANGE = 20

# How far away before the monster overwhelms the player
const ATTACK_RANGE = 1
##################################

onready var detection_raycast = $RayCast
onready var audio_breathing = $AudioBreathing
onready var audio_walking = $AudioWalking

# for pathfinding
onready var navigation = get_tree().get_root().get_node("World/Navigation")
var player_pos = null
var path = []
var path_ind = 0
# for pathfinding testing
onready var draw = get_tree().get_root().get_node("World/Draw")
var draw_path = false

# Return "Monster" instead of "KinematicBody" 
# This is so we can check if an object is a monster
func get_class():
	return "Monster"

func _ready():
	add_to_group("monsters")
	stop_moving()
	
	# Start breathing at some random interval so monster's aren't all breathing in sync
	audio_breathing.play(rand_range(0, 5))

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
	
	# Check if a ray to player within detection range can be cast
	detection_raycast.cast_to = vec_to_player * detection_range
	if detection_raycast.is_colliding(): 
		# Make sure what the ray is colliding with is actually the player
		var raycast_collider = detection_raycast.get_collider()
		if raycast_collider != null and raycast_collider.name == "Player":
			if path.size() == 0:
				update_path() 
				start_moving()
			else:
				# Only set path again if the player's position has significantly changed
				if player_pos.distance_to(player.translation) > 1:
					update_path() 
	
	# If we haven't traversed the path yet
	if path_ind < path.size():
		var target_pos = get_curr_path_section_target_pos()
		
		var move_vec = (target_pos - global_transform.origin)
		if move_vec.length() < 0.1:
			path_ind += 1
		else:
			move_vec = move_vec.normalized()
			var collision = move_and_collide(move_vec * MOVE_SPEED * delta)
			if collision != null and collision.get_collider().get_class() == "Player":
				collision.get_collider().kill()
		
		# Look where we're going
		# We may have just finished a section of the path, so get the newest target_pos for looking
		target_pos = get_curr_path_section_target_pos()
		top_looker.look_at(target_pos, UP)
		
		# If that finished the path
		if path_ind >= path.size():
			stop_moving()

# Get the target position of the path subsection we are currently following
# Since the world is flat, we don't want to consider the y dimension
func get_curr_path_section_target_pos():
	var target_pos = path[path_ind]
	target_pos.y = global_transform.origin.y
	return target_pos

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

# slightly fuzzy position check
func is_at_pos(pos):
	return !(translation.x - pos.x > 0.1 || translation.y - pos.y > 0.1 || translation.z - pos.z > 0.1)

func kill():
	remove_from_group("monsters")
	queue_free()

func update_path():
	if navigation != null:
		player_pos = player.global_transform.origin
		
		var begin = global_transform.origin
		var end = player_pos
		
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
