extends KinematicBody

# Script controlling the camera, player animations, input, and movement
##################################

const RUN_SPEED = 3.5      
const SNEAK_SPEED = 2
const BACKWARDS_SLOWDOWN = 0.5
const INTERACT_RANGE = 1 # Range player can interact with objects
##################################

onready var SOUND_MATCH_ON = load("res://Sound/Effects/Match/match_on.wav")
onready var SOUND_MATCH_OFF = load("res://Sound/Effects/Match/match_off.wav")
onready var SOUND_MATCH_BURNING = load("res://Sound/Effects/Match/match_burning.wav")

onready var audio_player = $FirstPersonAudio
onready var match_burning_audio = $MatchBurningAudio
onready var audio_fader = $AudioFader
onready var music_player = get_node("/root/MusicPlayer")

onready var memory_controller = $CanvasLayer/MemoryController
onready var stamina_controller = $CanvasLayer/StaminaController
onready var globals = get_node("/root/Globals")
onready var dialogue = get_node("/root/Dialogue")

onready var anim_hand = $"CanvasLayer/Hand/Hand Sprite/HandAnimator"
onready var headbobber = $Headbobber
onready var raycast = $RayCast
onready var torch_collision_shape = $Torch/TorchArea/CollisionShape
onready var prompt_label = $"CanvasLayer/Prompt Label"

onready var torch = $Torch

onready var start_pos = translation

export var in_finale = false

var game_over = false
var dying = false
var moving = false
var running = false
var changing_match_state = false

# Return "Player" instead of "KinematicBody" 
# This is so we can check if an object is the player
func get_class():
	return "Player"

func _ready():
	if globals.in_memory:
		memory_controller.return_from_memory()
	else:
		memory_controller.return_from_death()
	
	set_torch(false)
	anim_hand.play("idle_off")
	
	yield(get_tree(), "idle_frame")

func _input(event):	
	if dying or globals.in_memory: 
		return
	
	if event is InputEventMouseMotion:
		var mouse_sens = globals.get_mouse_sens()
		# Horizontal camera
		rotation_degrees.y -= mouse_sens * event.relative.x
		
		# Vertical camera
		rotation_degrees.x -= mouse_sens * event.relative.y
		rotation_degrees.x = max(min(rotation_degrees.x, 85), -85)
	
	# Check for torch toggling
	if !in_finale and event.is_action_pressed("shoot"):
		toggle_torch()
	
	# DEBUG: Teleport to level
	if event.is_action_pressed("teleport_kitchen"):
		get_tree().change_scene("res://Scenes/Worlds/Kitchen.tscn")
	if event.is_action_pressed("teleport_study"):
		get_tree().change_scene("res://Scenes/Worlds/Study.tscn")
	if event.is_action_pressed("teleport_bedroom"):
		get_tree().change_scene("res://Scenes/Worlds/Bedroom.tscn")
	if event.is_action_pressed("teleport_finale"):
		get_tree().change_scene("res://Scenes/Worlds/Finale.tscn")
	if event.is_action_pressed("teleport_credits"):
		get_tree().change_scene("res://Scenes/Credits.tscn")

func _physics_process(delta):
	if dying or globals.in_memory:
		return
	
	# Move more slowly backwards
	var moving_backwards = false
	
	var move_vec = Vector3()
	if Input.is_action_pressed("move_forwards"):
		move_vec.z -= 1
	if Input.is_action_pressed("move_backwards"):
		move_vec.z += 1
		moving_backwards = true
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	
	# Handling movement speed and headbob speed
	moving = move_vec.x != 0 or move_vec.z != 0
	running = moving && Input.is_action_pressed("run") && stamina_controller.can_run()
	var move_speed = SNEAK_SPEED
	headbobber.playback_speed = 1
	# If we are actually moving:
	if moving:
		if not headbobber.is_playing():
			headbobber.play("headbob")
		
		if running:
			move_speed = RUN_SPEED
			headbobber.playback_speed = 2
		
		# Move more slowly backwards
		if moving_backwards:
			move_speed *= BACKWARDS_SLOWDOWN
			headbobber.playback_speed *= BACKWARDS_SLOWDOWN
	else:
		if headbobber.is_playing():
			headbobber.stop()
			# Plays an animation that goes back to default position
			headbobber.play("reset")
	
	stamina_controller.update_stamina(moving, running)
	
	# Actually move
	move_and_slide(move_vec * move_speed)
	translation.y = 0 # Stop player from climbing over some objects
	
	# Check if player is looking at anything interactable that is within range
	var coll = raycast.get_collider()
	if raycast.is_colliding() and coll != null and coll.has_method("interact"): 
		#  Can only interact if close and the match is on
		if raycast.get_collision_point().distance_to(translation) < INTERACT_RANGE:
				if !coll.has_method("can_interact") or coll.can_interact(torch.visible):
					enable_interact_prompt()
					
					if Input.is_action_just_pressed("interact"):
						coll.interact(self)
				else:
					disable_prompt()
		else:
			disable_prompt()
	else:
		disable_prompt()

func toggle_torch():
	if anim_hand.current_animation != "light_on" and anim_hand.current_animation != "light_off":
		set_torch(!torch.visible)

func set_torch(on):
	if on && !torch.visible:
		changing_match_state = true
		match_burning_audio.play()
		audio_fader.play("fade in burning")
		play_audio(SOUND_MATCH_ON)
		anim_hand.play("light_on")
	elif !on && torch.visible:
		changing_match_state = true
		match_burning_audio.stop()
		play_audio(SOUND_MATCH_OFF)
		anim_hand.play("light_off")

# When finishing lighting or unlighting match, 
# play the correct idle anim (match flicker or nothing) and change light
func _on_HandAnimator_animation_finished(anim_name):
	if anim_name == "light_on":
		anim_hand.play("idle_on")
		changing_match_state = false
	elif anim_name == "light_off":
		torch.visible = false
		torch_collision_shape.disabled = true
		anim_hand.play("idle_off")
		changing_match_state = false

# Called by the animation at the exact moment when the match is lit
func anim_match_lit():
	torch.visible = true
	torch_collision_shape.disabled = false

func get_torch_visible():
	return torch.visible

func kill():
	if not dying:
		dying = true
		music_player.play_dying()
		memory_controller.screen_animator.play("Fade To Black")

func play_audio(stream):
	audio_player.set_stream(stream)
	audio_player.play()

func enable_interact_prompt():
	prompt_label.text = dialogue.get_subtitles(dialogue.INTERACT_PROMPT)
	prompt_label.visible_characters = -1

func disable_prompt():
	prompt_label.visible_characters = 0

# Called when interacting with final item
# Starts the process, fading into the memory
func start_final_memory(final_item):
	memory_controller.start_final_memory(final_item)

# Plays sound and displays text 
func play_dialogue(dialogue):
	memory_controller.play_dialogue(dialogue)

# When timer finishes
func _on_Timer_timeout():
	game_over = true
	memory_controller.screen_animator.play("Fade To Black")
