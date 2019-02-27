extends KinematicBody

# Script controlling the camera, player animations, input, and movement
##################################

const RUN_SPEED = 4
const SNEAK_SPEED = 2
const MOUSE_SENS = 0.2
const INTERACT_RANGE = 2 # Range player can interact with objects

onready var SOUND_MATCH_ON = load("res://Sound/Effects/Match/match_on.wav")
onready var SOUND_MATCH_OFF = load("res://Sound/Effects/Match/match_off.wav")
onready var SOUND_MATCH_BURNING = load("res://Sound/Effects/Match/match_burning.wav")
onready var SOUND_TAPSHOE = load("res://Sound/Effects/Memory/study_tapshoe.wav")
onready var INTERACT_PROMPT = "Press " + InputMap.get_action_list("interact")[0].as_text() + " to interact"

onready var audio_player = $FirstPersonAudio
onready var match_burning_audio = $MatchBurningAudio
onready var audio_fader = $AudioFader

onready var anim_player = $AnimationPlayer
onready var headbobber = $Headbobber
onready var raycast = $RayCast
onready var prompt_label = $"CanvasLayer/Prompt Label"
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
	
	audio_fader.play("fade in music")
	# Play audio depending on torch state
	if torch.visible:
		match_burning_audio.play()

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
	
	move_and_collide(move_vec * move_speed * delta)
	
	if Input.is_action_pressed("shoot") and !anim_player.is_playing():
		if !torch.visible:
			match_burning_audio.play()
			audio_fader.play("fade in burning")
			play_audio(SOUND_MATCH_ON)
			anim_player.play("light")
		else:
			match_burning_audio.stop()
			play_audio(SOUND_MATCH_OFF)
			anim_player.play_backwards("light")
		
		torch.visible = !torch.visible
	
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
	return torch.visible

func kill():
	if not dying:
		dying = true
		anim_player.play("Fade To Black")

func play_audio(stream):
	audio_player.set_stream(stream)
	audio_player.play()

# When animation player finishes any animation
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade To Black":
		if game_over == true:
			# Finished the game
			get_tree().quit()
		elif dying == true:
			# We died, restart
			get_tree().reload_current_scene()
	
	if anim_name == "Fade To White":
		in_memory = true
		play_audio(SOUND_TAPSHOE)
		
	if anim_name == "Fade From White":
		$Timer.start()

# When audio player finishes playing audio
func _on_FirstPersonAudio_finished():
	if in_memory:
		in_memory = false 
		anim_player.play("Fade From White")
		
		translation = start_pos
		rotation = Vector3(0, 180, 0)
		
		var blockedPath = owner.get_node("BlockedPath")
		if blockedPath != null:
			blockedPath.hide()

# When timer finishes
func _on_Timer_timeout():
	game_over = true
	anim_player.play("Fade To Black")
