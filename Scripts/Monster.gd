extends KinematicBody

# Script controlling the monsters
##################################

const MOVE_SPEED = 2

# How far the monster can see the player when player is dark or lit
const DETECT_DARK_RANGE = 5
const DETECT_LIT_RANGE = 25 

# How far away before the monster overwhelms the player
const ATTACK_RANGE = 1

onready var detection_raycast = $RayCast
onready var anim_player = $AnimationPlayer

var player = null
var in_player_area = false # If not in range of the player, don't run AI
var dead = false
var detected_player = false

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
	
	var vec_to_player = player.translation - translation
	vec_to_player = vec_to_player.normalized()
	
	# Check if a ray to player within detection range can be cast
	detection_raycast.cast_to = vec_to_player * detection_range	
	if detection_raycast.is_colliding():
		# Make sure what the ray is colliding with is actually the player
		var raycast_collider = detection_raycast.get_collider()
		if raycast_collider != null and raycast_collider.name == "Player":
			if not detected_player:
				anim_player.stop()
				detected_player = true
			
			var collision = move_and_collide(vec_to_player * MOVE_SPEED * delta)
			if collision != null and collision.get_collider().get_class() == "Player":
				collision.get_collider().kill()
		else:
			stop_chasing()
	else: 
		stop_chasing()
	
	if not anim_player.is_playing():
		if detected_player:
			anim_player.play("walk")
		else:
			anim_player.play("idle")

func stop_chasing():
	if detected_player:
		anim_player.stop()
		detected_player = false

func kill():
	dead = true
	$CollisionShape.disabled = true
	anim_player.play("die")
