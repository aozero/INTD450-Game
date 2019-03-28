extends KinematicBody

# Script controlling the camera, player animations, input, and movement
##################################

const RUN_SPEED = 4      
const SNEAK_SPEED = 2
const BACKWARDS_SLOWDOWN = 0.5
const MOUSE_SENS = 0.2
const INTERACT_RANGE = 1 # Range player can interact with objects
##################################

onready var SOUND_MATCH_ON = load("res://Sound/Effects/Match/match_on.wav")
onready var SOUND_MATCH_OFF = load("res://Sound/Effects/Match/match_off.wav")
onready var SOUND_MATCH_BURNING = load("res://Sound/Effects/Match/match_burning.wav")

onready var INTERACT_PROMPT = "Press " + InputMap.get_action_list("interact")[0].as_text() + " to interact"

onready var audio_player = $FirstPersonAudio
onready var match_burning_audio = $MatchBurningAudio
onready var audio_fader = $AudioFader
onready var music_player = get_node("/root/MusicPlayer")

onready var memory_controller = $CanvasLayer/MemoryController
onready var globals = get_node("/root/Globals")

# Sprite to display in the center of the screen as it fades out from the memory
export(Texture) var last_final_item_sprite setget set_last_final_item_sprite
func set_last_final_item_sprite(tex):
	last_final_item_sprite = tex

onready var anim_hand = $"CanvasLayer/Hand/Hand Sprite/HandAnimator"
onready var headbobber = $Headbobber
onready var raycast = $RayCast
onready var torch_collision_shape = $Torch/TorchArea/CollisionShape
onready var prompt_label = $"CanvasLayer/Prompt Label"

onready var torch = $Torch

onready var start_pos = translation

var game_over = false
var dying = false
var running = false

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
	
	yield(get_tree(), "idle_frame")

func _input(event):	
	if dying or globals.in_memory: 
		return
	
	if event is InputEventMouseMotion:
		# Horizontal camera
		rotation_degrees.y -= MOUSE_SENS * event.relative.x
		
		# Vertical camera
		rotation_degrees.x -= MOUSE_SENS * event.relative.y
		rotation_degrees.x = max(min(rotation_degrees.x, 85), -85)
		
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
	running = false
	var move_speed = SNEAK_SPEED
	headbobber.playback_speed = 1
	# If we are actually moving:
	if move_vec.x != 0 or move_vec.z != 0:
		if not headbobber.is_playing():
			headbobber.play("headbob")
		
		if Input.is_action_pressed("run"):
			running = true
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
	
	# Actually move
	move_and_slide(move_vec * move_speed)
	translation.y = 0 # Stop player from climbing over some objects
	
	# Check for torch toggling
	# TODO: Minor, but this would be better in an event based input system rather than checking constantly
	if Input.is_action_pressed("shoot") and anim_hand.current_animation != "light":
		toggle_torch()
	
	# Check if player is looking at anything interactable that is within range
	var coll = raycast.get_collider()
	if raycast.is_colliding() and coll != null and coll.has_method("interact"): 
		#  Can only interact if close and the match is on
		if raycast.get_collision_point().distance_to(translation) < INTERACT_RANGE && torch.visible:
				enable_interact_prompt()
				
				if Input.is_action_pressed("interact"):
					coll.interact(self)
		else:
			disable_prompt()
		
	else:
		disable_prompt()

func toggle_torch():
	set_torch(!torch.visible)

func set_torch(on):
	if on && !torch.visible:
		match_burning_audio.play()
		audio_fader.play("fade in burning")
		play_audio(SOUND_MATCH_ON)
		anim_hand.play("light")
	elif !on && torch.visible:
		match_burning_audio.stop()
		play_audio(SOUND_MATCH_OFF)
		anim_hand.play_backwards("light")
	
	torch.visible = on
	torch_collision_shape.disabled = !on

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
	prompt_label.text = INTERACT_PROMPT
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

# When finishing lighting or unlighting match, play the correct idle anim (match flicker or nothing)
func _on_HandAnimator_animation_finished(anim_name):
	if anim_name == "light":
		if torch.visible:
			anim_hand.play("idle_on")
		else:
			anim_hand.play("idle_off")
	


