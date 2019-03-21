extends Node

onready var SCREEN_MEMORY_COLOR = Color(0.89, 0.89, 0.89)
onready var SCREEN_DEATH_COLOR = Color(0, 0, 0)
onready var DIALOGUE_MINOR_FONT_COLOR = Color(1, 1, 1)
onready var DIALOGUE_MINOR_FONT_SHADOW = Color(0, 0, 0)
onready var DIALOGUE_FINAL_FONT_COLOR = Color(0, 0, 0)
onready var DIALOGUE_FINAL_FONT_SHADOW = Color(1, 1, 1)

onready var player = get_tree().get_root().get_node("World/Player")
onready var screen_rect = $ScreenRect
onready var screen_animator = $ScreenAnimator
onready var item_sprite = $"ScreenRect/CenterDot/Item Sprite"
onready var dialogue_audio = $DialogueAudio
onready var dialogue_label = $"Dialogue Label"
onready var dialogue_timer = $"Dialogue Label/Dialogue Timer"
onready var music_player = get_node("/root/MusicPlayer")
onready var globals = get_node("/root/Globals")

var curr_final_item = null

"""
Plays sound and displays text 
dialogue.SOUND - the sound to play
dialogue.TEXT - the subtitle text to display
dialogue.TEXT_TIME - how long in seconds the text should stay up for
"""
func play_dialogue(dialogue):
	dialogue_audio.stream = dialogue.SOUND
	dialogue_audio.play()
	
	dialogue_label.text = dialogue.TEXT 
	dialogue_label.visible_characters = -1
	
	dialogue_timer.wait_time = dialogue.TEXT_TIME
	dialogue_timer.start()

# Dialogue has been up long enough, get rid of it
func _on_Dialogue_Timer_timeout():
	dialogue_label.visible_characters = 0

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
	globals.in_memory = true
	player.set_torch(false)
	player.audio_player.stop()
	
	dialogue_label.add_color_override("font_color", DIALOGUE_FINAL_FONT_COLOR)
	dialogue_label.add_color_override("font_color_shadow", DIALOGUE_FINAL_FONT_SHADOW)
	dialogue_label.text = curr_final_item.DIALOGUE.TEXT 
	dialogue_label.visible_characters = -1
	dialogue_audio.stream = curr_final_item.DIALOGUE.SOUND
	dialogue_audio.play()

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
	if player.last_final_item_sprite != null:
		item_sprite.texture = player.last_final_item_sprite
	
	screen_rect.color = SCREEN_MEMORY_COLOR
	screen_animator.play("Fade From Memory")
	
	globals.in_memory = false

# If loading at beginning of game or after dying, fade in from black
func return_from_death():
	screen_rect.color = SCREEN_DEATH_COLOR
	screen_animator.play_backwards("Fade To Black")

# When dialogue player finishes playing audio
func _on_DialogueAudio_finished():
	if globals.in_memory:
		end_final_memory()

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