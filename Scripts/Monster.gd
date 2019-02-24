extends KinematicBody

# Script controlling the monsters
##################################

const MOVE_SPEED = 2

# How far the monster can see the player when player is dark or lit
const DETECT_DARK_RANGE = 4
const DETECT_LIT_RANGE = 10 
const DETECT_RUN_MULTIPLIER = 2

# How far away before the monster overwhelms the player
const ATTACK_RANGE = 1

onready var detection_raycast = $RayCast
onready var anim_player = $AnimationPlayer

# for pathfinding
onready var navigation = get_parent().get_node("Navigation")
var path = []
var path_ind = 0
# for pathfinding testing
onready var draw = get_parent().get_node("Draw")
var draw_path = true 

var player = null
var dead = false

# Return "Monster" instead of "KinematicBody" 
# This is so we can check if an object is a monster
func get_class():
	return "Monster"

func _ready():
	add_to_group("monsters")
	anim_player.play("idle")
	set_in_player_area(false)

# Called by Player
func set_player(p):
	player = p

# Called by Player Area
func set_in_player_area(value):
	set_physics_process(value)

func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
	
	# Set detection range based on player's state
	var detection_range = DETECT_DARK_RANGE
	if player.get_torch_visible():
		detection_range = DETECT_LIT_RANGE
	if player.running:
		detection_range *= DETECT_RUN_MULTIPLIER
	
	var vec_to_player = player.translation - translation
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
				if path[path.size() - 1].distance_to(player.translation) > 1:
					update_path() 
	
	# If we haven't traversed the path yet
	if path_ind < path.size():
		var move_vec = (path[path_ind] - global_transform.origin)
		move_vec.y = 0
		if move_vec.length() < 0.1:
			path_ind += 1
		else:
			move_vec = move_vec.normalized()
			var collision = move_and_collide(move_vec * MOVE_SPEED * delta)
			if collision != null and collision.get_collider().get_class() == "Player":
				collision.get_collider().kill()
		
		# If that finished the path
		if path_ind >= path.size():
			stop_moving()

# Called when changing from idle to moving
func start_moving():
	anim_player.stop()
	anim_player.play("walk")

# Called when changing from moving to idle
func stop_moving():
	path = []
	anim_player.stop()
	anim_player.play("idle")

# slightly fuzzy position check
func is_at_pos(pos):
	return !(translation.x - pos.x > 0.1 || translation.y - pos.y > 0.1 || translation.z - pos.z > 0.1)

func kill():
	dead = true
	$CollisionShape.disabled = true
	anim_player.play("die")

func update_path():
	if navigation != null:
		var begin = global_transform.origin
		var end = player.translation
		
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
