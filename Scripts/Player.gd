extends KinematicBody

# Script controlling the camera, player animations, input, and movement
##################################

const MOVE_SPEED = 4
const MOUSE_SENS = 0.2
const INTERACT_RANGE = 2 # Range player can interact with objects

onready var anim_player = $AnimationPlayer
onready var raycast = $RayCast
onready var prompt_label = $"CanvasLayer/Prompt Label"

# Return "Player" instead of "KinematicBody" 
# This is so we can check if an object is the player
func get_class():
	return "Player"
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	yield(get_tree(), "idle_frame")
	get_tree().call_group("monsters", "set_player", self)

func _input(event):
	if event is InputEventMouseMotion:
		# Horizontal camera
		rotation_degrees.y -= MOUSE_SENS * event.relative.x
		
		# Vertical camera
		rotation_degrees.x -= MOUSE_SENS * event.relative.y
		rotation_degrees.x = max(min(rotation_degrees.x, 85), -85)
	if event.is_action_pressed("toggle_fullscreen"):
		print("full screen")
		OS.window_fullscreen = !OS.window_fullscreen

func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	if Input.is_action_pressed("restart"):
		kill()

func _physics_process(delta):
	var move_vec = Vector3()
	if Input.is_action_pressed("move_forwards"):
		move_vec.z -= 1
	if Input.is_action_pressed("move_backwards"):
		move_vec.z += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_and_collide(move_vec * MOVE_SPEED * delta)
	
	if Input.is_action_pressed("shoot") and !anim_player.is_playing():
		get_node("Torch").visible = !get_node("Torch").visible
		anim_player.play("shoot")
		#var coll = raycast.get_collider()
		#if raycast.is_colliding() and coll.has_method("kill"):
		#	coll.kill()
	
	# Check if player is looking at anything interactable that is within range
	var coll = raycast.get_collider()
	if raycast.is_colliding() and coll != null and coll.has_method("interact"): 
		if raycast.get_collision_point().distance_to(translation) < INTERACT_RANGE:
			enable_prompt_label()
			
			if Input.is_action_pressed("interact"):
				coll.interact()
		else:
			disable_prompt_label()
		
	else:
		disable_prompt_label()

func enable_prompt_label():
	prompt_label.visible_characters = -1

func disable_prompt_label():
	prompt_label.visible_characters = 0

func get_torch_visible():
	return get_node("Torch").visible

func kill():
	get_tree().reload_current_scene()
