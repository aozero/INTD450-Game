extends Node

onready var SCREEN_MEMORY_COLOR = Color(0.89, 0.89, 0.89)
onready var SCREEN_DEATH_COLOR = Color(0, 0, 0)
onready var DIALOGUE_MINOR_FONT_COLOR = Color(1, 1, 1)
onready var DIALOGUE_MINOR_FONT_SHADOW = Color(0, 0, 0)
onready var DIALOGUE_FINAL_FONT_COLOR = Color(0, 0, 0)
onready var DIALOGUE_FINAL_FONT_SHADOW = Color(1, 1, 1)

const LOOKING_WAIT_TIME = 0.1       # How long to wait after looking at an item before being able to interact again
const MINOR_MEMORY_WAIT_TIME = 3.0  # How long to wait after starting minor memory before being able to start another
const FINAL_MEMORY_EXTRA_TIME = 1.5 # How long to wait after final memory audio ends

onready var player = get_owner()
onready var screen_rect = $ScreenRect
onready var screen_animator = $ScreenAnimator
onready var item_sprite = $"ScreenRect/CenterDot/Item Sprite"
onready var dialogue_audio = $DialogueAudio
onready var dialogue_label = $"Dialogue Label"
onready var dialogue_timer = $"Dialogue Label/Dialogue Timer"
onready var memory_timer = $DialogueAudio/MemoryTimer
onready var music_player = get_node("/root/MusicPlayer")
onready var dialogue = get_node("/root/Dialogue")
onready var globals = get_node("/root/Globals")

var curr_final_item = null
var looking_at_item = false

# Displays text at bottom of screen if there should be subtitles
func show_subtitles(item_dialogue):
	dialogue_label.text = dialogue.get_subtitles(item_dialogue)
	dialogue_label.visible_characters = -1

"""
Plays sound and displays text 
item_dialogue.SOUND - the sound to play
item_dialogue.TEXT_TIME - how long in seconds the text should stay up for
"""
func play_dialogue(item_dialogue):
	dialogue_audio.stream = item_dialogue.SOUND
	dialogue_audio.play()
	
	show_subtitles(item_dialogue)
	
	dialogue_timer.wait_time = item_dialogue.TEXT_TIME
	dialogue_timer.start()

# Dialogue has been up long enough, get rid of it
func _on_Dialogue_Timer_timeout():
	dialogue_label.visible_characters = 0

func start_minor_memory(item_dialogue):
	if memory_timer.is_stopped():
		play_dialogue(item_dialogue)
		
		# Player must wait before interacting again
		memory_timer.wait_time = MINOR_MEMORY_WAIT_TIME
		memory_timer.start()

# Make item appear in the center of the screen and pause the game
func look_at_item(texture, item_dialogue):
	if memory_timer.is_stopped():
		looking_at_item = true
		item_sprite.texture = texture
		item_sprite.modulate.a = 1
		item_sprite.visible = true
		start_minor_memory(item_dialogue)
		get_tree().paused = true

# Return to normal game after looking at item
# Called from PauseController because it is the master of unpausing
func stop_looking_at_item():
	if looking_at_item:
		looking_at_item = false
		item_sprite.texture = null
		dialogue_label.visible_characters = 0
		get_tree().paused = false
		
		# Player must wait before interacting again
		memory_timer.wait_time = LOOKING_WAIT_TIME
		memory_timer.start()

# Called when interacting with final item
# Starts the process, fading into the memory
func start_final_memory(final_item):
	curr_final_item = final_item
	
	# Don't want monsters to interrupt our reminiscing
	get_tree().call_group("monsters", "kill")
	
	# Set up and play memory sequence
	item_sprite.texture = curr_final_item.sprite.texture
	music_player.play_melody(curr_final_item.DIALOGUE.MUSIC)
	screen_animator.play("Fade To Memory")

# We've faded into the memory and start actually playing the audio
func in_final_memory():
	dialogue_timer.stop()
	globals.in_memory = true
	player.set_torch(false)
	player.audio_player.stop()
	
	dialogue_label.add_color_override("font_color", DIALOGUE_FINAL_FONT_COLOR)
	dialogue_label.add_color_override("font_color_shadow", DIALOGUE_FINAL_FONT_SHADOW)
	show_subtitles(curr_final_item.DIALOGUE)
	dialogue_audio.stream = curr_final_item.DIALOGUE.SOUND
	dialogue_audio.play()
	
	# Start timer to wait until memory is over to end it.
	memory_timer.wait_time = dialogue_audio.stream.get_length() + FINAL_MEMORY_EXTRA_TIME
	memory_timer.start()

# The memory has finished
# However, we still need to fade out with return_from_memory, called by Player._ready()
func end_final_memory():
	screen_animator.play("Fade From Memory")
	music_player.stop_melody()
	
	dialogue_label.visible_characters = 0
	dialogue_label.add_color_override("font_color", DIALOGUE_MINOR_FONT_COLOR)
	dialogue_label.add_color_override("font_color_shadow", DIALOGUE_MINOR_FONT_SHADOW)
	
	curr_final_item.after_memory()

# We are returning from a memory
func return_from_memory():	
	screen_rect.color = SCREEN_MEMORY_COLOR
	screen_animator.play("Fade From Memory")
	
	globals.in_memory = false

# If loading at beginning of game or after dying, fade in from black
func return_from_death():
	screen_rect.color = SCREEN_DEATH_COLOR
	screen_animator.play_backwards("Fade To Black")

# When screen animator finishes any animation
func _on_ScreenAnimator_animation_finished(anim_name):
	if anim_name == "Fade To Black":
		if player.game_over == true:
			# Finished the game
			get_tree().quit()
		elif player.dying == true:
			# We died, restart
			get_tree().reload_current_scene()
	
	if anim_name == "Fade To Memory":
		in_final_memory()

func _on_MemoryTimer_timeout():
	if globals.in_memory:
		end_final_memory()
