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

onready var target_pos = null # target position we want to move to 
var player = null
var in_player_area = false # If not in range of the player, don't run AI
var dead = false


# Return "Monster" instead of "KinematicBody" 
# This is so we can check if an object is a monster
func get_class():
	return "Monster"

func _ready():
	add_to_group("monsters")
	anim_player.play("idle")

# Called by Player
func set_player(p):
	player = p

# Called by Player Area
func set_in_player_area(value):
	in_player_area = value

func _physics_process(delta):
	if not in_player_area:
		return
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
	print(detection_range)
	
	var vec_to_player = player.translation - translation
	vec_to_player = vec_to_player.normalized()
	
	# Check if a ray to player within detection range can be cast
	detection_raycast.cast_to = vec_to_player * detection_range	
	if detection_raycast.is_colliding():
		# Make sure what the ray is colliding with is actually the player
		var raycast_collider = detection_raycast.get_collider()
		if raycast_collider != null and raycast_collider.name == "Player":
			if target_pos == null:
				start_moving()
			
			target_pos = player.translation
	
	# If we have a target_pos, we are currently moving towards that point
	if target_pos != null:
		if is_at_pos(target_pos):
			# We have reached our target
			stop_moving()
		else:
			# We have not reached our target; keep moving
			var vec_to_target = target_pos - translation
			vec_to_target = vec_to_target.normalized()
			
			var collision = move_and_collide(vec_to_target * MOVE_SPEED * delta)
			if collision != null and collision.get_collider().get_class() == "Player":
				collision.get_collider().kill()

# Called when changing from idle to moving
func start_moving():
	anim_player.stop()
	anim_player.play("walk")

# Called when changing from moving to idle
func stop_moving():
	target_pos = null
	anim_player.stop()
	anim_player.play("idle")

# slightly fuzzy position check
func is_at_pos(pos):
	var my_pos = translation
	return my_pos.x - pos.x < 0.5 && my_pos.y - pos.y < 0.5 && my_pos.z - pos.z < 0.5

func kill():
	dead = true
	$CollisionShape.disabled = true
	anim_player.play("die")
