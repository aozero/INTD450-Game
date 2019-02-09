extends KinematicBody

# Script controlling the camera, player animations, input, and movement
##################################

const MOVE_SPEED = 4
const MOUSE_SENS = 0.2
const INTERACT_RANGE = 2 # Range player can interact with objects

onready var SOUND_MATCH_ON = load("res://Sound/Effects/match_on.wav")
onready var SOUND_MATCH_OFF = load("res://Sound/Effects/match_off.wav")
onready var SOUND_TAPSHOE = load("res://Sound/Effects/Memory Clips/Tap Shoe.wav")
onready var INTERACT_PROMPT = "Press " + InputMap.get_action_list("interact")[0].as_text() + " to interact"

onready var anim_player = $AnimationPlayer
onready var audio_player = $FirstPersonAudio
onready var raycast = $RayCast
onready var prompt_label = $"CanvasLayer/Prompt Label"

onready var start_pos = translation

var dying = false
var in_memory = false

# Return "Player" instead of "KinematicBody" 
# This is so we can check if an object is the player
func get_class():
	return "Player"
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	yield(get_tree(), "idle_frame")
	get_tree().call_group("monsters", "set_player", self)
	anim_player.play_backwards("Fade To Black")

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if dying or in_memory: 
		return
	
	if event is InputEventMouseMotion:
		# Horizontal camera
		rotation_degrees.y -= MOUSE_SENS * event.relative.x
		
		# Vertical camera
		rotation_degrees.x -= MOUSE_SENS * event.relative.y
		rotation_degrees.x = max(min(rotation_degrees.x, 85), -85)
	

func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	if Input.is_action_pressed("restart"):
		kill()

func _physics_process(delta):
	if dying or in_memory:
		return
	
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
		
		if !get_node("Torch").visible:
			play_audio(SOUND_MATCH_ON)
			anim_player.play("light")
		else:
			play_audio(SOUND_MATCH_OFF)
			anim_player.play_backwards("light")
		
		get_node("Torch").visible = !get_node("Torch").visible
	
	# Check if player is looking at anything interactable that is within range
	var coll = raycast.get_collider()
	if raycast.is_colliding() and coll != null and coll.has_method("interact"): 
		if raycast.get_collision_point().distance_to(translation) < INTERACT_RANGE:
			enable_interact_prompt()
			
			if Input.is_action_pressed("interact"):
				coll.interact(self)
		else:
			disable_prompt()
		
	else:
		disable_prompt()

func enable_interact_prompt():
	prompt_label.text = INTERACT_PROMPT
	prompt_label.visible_characters = -1

func disable_prompt():
	prompt_label.visible_characters = 0

func get_torch_visible():
	return get_node("Torch").visible

func kill():
	if not dying:
		dying = true
		anim_player.play("Fade To Black")

func move_to_start_pos():
	translation = start_pos

func play_audio(stream):
	audio_player.set_stream(stream)
	audio_player.play()

# Called when animation player finishes any animation
func _on_AnimationPlayer_animation_finished(anim_name):
	if dying == true and anim_name == "Fade To Black":
		# We died, restart
		get_tree().reload_current_scene()
	if anim_name == "Fade To White":
		in_memory = true
		play_audio(SOUND_TAPSHOE)


func _on_FirstPersonAudio_finished():
	if in_memory:
		in_memory = false
		move_to_start_pos()
		anim_player.play("Fade From White")
