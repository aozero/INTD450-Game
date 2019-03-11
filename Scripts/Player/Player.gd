extends KinematicBody

# Script controlling the camera, player animations, input, and movement
##################################

const RUN_SPEED = 4      
const SNEAK_SPEED = 2
const MOUSE_SENS = 0.2
const INTERACT_RANGE = 2 # Range player can interact with objects
##################################

onready var SOUND_MATCH_ON = load("res://Sound/Effects/Match/match_on.wav")
onready var SOUND_MATCH_OFF = load("res://Sound/Effects/Match/match_off.wav")
onready var SOUND_MATCH_BURNING = load("res://Sound/Effects/Match/match_burning.wav")
onready var SOUND_TAPSHOE = load("res://Sound/Effects/Memory/study_tapshoe.wav")

onready var INTERACT_PROMPT = "Press " + InputMap.get_action_list("interact")[0].as_text() + " to interact"

onready var audio_player = $FirstPersonAudio
onready var match_burning_audio = $MatchBurningAudio
onready var audio_fader = $AudioFader
onready var music_player = get_node("/root/MusicPlayer")

onready var anim_player = $AnimationPlayer
onready var headbobber = $Headbobber
onready var raycast = $RayCast
onready var torch_collision_shape = $Torch/TorchArea/CollisionShape
onready var prompt_label = $"CanvasLayer/Prompt Label"
onready var dialogue_label = $"CanvasLayer/Dialogue Label"
onready var dialogue_timer = $"CanvasLayer/Dialogue Label/Dialogue Timer"
onready var torch = $Torch

onready var start_pos = translation

var game_over = false
var dying = false
var in_memory = false
var running = false

# Return "Player" instead of "KinematicBody" 
# This is so we can check if an object is the player
func get_class():
	return "Player"
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	yield(get_tree(), "idle_frame")
	
	anim_player.play_backwards("Fade To Black")
	set_torch(false)

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
		
	var move_speed = SNEAK_SPEED
	running = false
	headbobber.playback_speed = 1
	# If we are actually moving:
	if move_vec.x != 0 or move_vec.z != 0:
		if not headbobber.is_playing():
			headbobber.play("headbob")
		
		if Input.is_action_pressed("run"):
			running = true
			move_speed = RUN_SPEED
			headbobber.playback_speed = 2
		else:
			headbobber.playback_speed = 1
	else:
		if headbobber.is_playing():
			headbobber.stop()
			# Plays an animation that goes back to default position
			headbobber.play("reset")  
	
	move_and_slide(move_vec * move_speed)
	
	if Input.is_action_pressed("shoot") and !anim_player.is_playing():
		toggle_torch()
	
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

func toggle_torch():
	set_torch(!torch.visible)

func set_torch(on):
	if on && !torch.visible:
		match_burning_audio.play()
		audio_fader.play("fade in burning")
		play_audio(SOUND_MATCH_ON)
		anim_player.play("light")
	elif !on && torch.visible:
		match_burning_audio.stop()
		play_audio(SOUND_MATCH_OFF)
		anim_player.play_backwards("light")
	
	torch.visible = on
	torch_collision_shape.disabled = !on

func get_torch_visible():
	return torch.visible

func kill():
	if not dying:
		dying = true
		music_player.play_dying()
		anim_player.play("Fade To Black")

func play_audio(stream):
	audio_player.set_stream(stream)
	audio_player.play()

func start_tapshoe_memory(music):
	get_tree().call_group("monsters", "kill")
	music_player.play_melody(music)
	anim_player.play("Fade To Tapshoe")

func start_minor_memory(memory_text):
	dialogue_label.text = memory_text 
	dialogue_label.visible_characters = -1
	dialogue_timer.start()

func _on_Dialogue_Timer_timeout():
	dialogue_label.visible_characters = 0

# When animation player finishes any animation
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade To Black":
		if game_over == true:
			# Finished the game
			get_tree().quit()
		elif dying == true:
			# We died, restart
			get_tree().reload_current_scene()
	
	if anim_name == "Fade To Tapshoe":
		in_memory = true
		set_torch(false)
		play_audio(SOUND_TAPSHOE)
		
		var blockedPath = get_tree().get_root().get_node("World/Navigation/NavigationMeshInstance/End Area/BlockedPath")
		if blockedPath != null:
			blockedPath.hide()
		var fireplace = get_tree().get_root().get_node("World/Navigation/NavigationMeshInstance/End Area/Fireplace")
		if fireplace != null:
			fireplace.turn_on()
		
	if anim_name == "Fade From Tapshoe":
		music_player.stop_melody()
		$Timer.start()

# When audio player finishes playing audio
func _on_FirstPersonAudio_finished():
	if in_memory:
		in_memory = false 
		anim_player.play("Fade From Tapshoe")

# When timer finishes
func _on_Timer_timeout():
	game_over = true
	anim_player.play("Fade To Black")