extends Node

# OPTIONS
########################################
# GENERAL
var mouse_sens = 0.08 setget set_mouse_sens, get_mouse_sens

func set_mouse_sens(value):
	mouse_sens = value

func get_mouse_sens():
	return mouse_sens

# AUDIO
# SUBTITLES
const NONE = 0
const ENGLISH = 1
var subtitles = NONE setget set_subtitles, get_subtitles

func set_subtitles(value):
	subtitles = value

func get_subtitles():
	return subtitles

# DISPLAY
# FULLSCREEN
func set_fullscreen(value):
	OS.window_fullscreen = value

func get_fullscreen():
	return OS.window_fullscreen

# Can always toggle fullscreen with hotkey, no matter what
func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		set_fullscreen(!OS.window_fullscreen)

# BRIGHTNESS
var brightness = 1 setget set_brightness, get_brightness
func set_brightness(value):
	brightness = value
	
	get_tree().call_group("cameras", "set_brightness", value)

func get_brightness():
	return brightness
	
# CONTRAST
var contrast = 1 setget set_contrast, get_contrast
func set_contrast(value):
	contrast = value
	
	get_tree().call_group("cameras", "set_contrast", value)

func get_contrast():
	return contrast

# FOREST QUALITY
# Levels of forest quality:
# Fastest is ForestTree alpha scissoring on
# Prettiest is ForestTree alpha scissoring off
var forest_material = load("res://Materials/ForestTree.tres")
var forest_quality = 0 setget set_forest_quality, get_forest_quality

func set_forest_quality(level):
	forest_quality = level
	
	if forest_quality == 0:
		forest_material.params_use_alpha_scissor = true
	elif forest_quality == 1:
		forest_material.params_use_alpha_scissor = false

func get_forest_quality():
	return forest_quality

# FOREST QUANTITY
# Levels of forest quantity:
# Less has second layer of forest invisible
# More has second layer of forest visible
var forest_quantity = 0 setget set_forest_quantity, get_forest_quantity

func set_forest_quantity(level):
	forest_quantity = level
	
	get_tree().call_group("extra forest", "set_visible", level)

func get_forest_quantity():
	return forest_quantity

# SHADOWS
onready var firelight = load("res://Scenes/Fires/FireLight.tscn").instance()
var shadows = false setget set_shadows, get_shadows

func set_shadows(value):
	shadows = value
	
	get_tree().call_group("lights", "set_shadows", value)

func get_shadows():
	return shadows
########################################

# Whether the player is currently experiencing a memory
var in_memory = false

# Variables that are global between each TreeForestWall and TreeRandom
var tree_frame_array = [1, 0, 0, 3, 1, 2, 2, 0, 1, 2, 3, 0, 1, 2] # Distribution of trees that gets cycled through
var tree_ind = 0              # Current position in tree_frame_array
var tree_nums = [0, 0, 0, 0]  # Counts for each kind of tree

# Variables that are global between each SmallFire
var fire_start_array = [0, 0.72, 0.36, 1.08, 0.12, 0.48, 1.44, 0.24, 1.2, 0.6, 1.32, 0.74, 0.96]
var fire_ind = 0       
