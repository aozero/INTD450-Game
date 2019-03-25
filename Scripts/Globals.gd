extends Node

# OPTIONS
########################################
# Levels of forest quality.
# Fastest is ForestTree alpha scissoring on
# Prettiest is ForestTree alpha scissoring off
const FOREST_QUALITY_TEXT = ["Fastest", "Prettiest"]
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

# Shadows
onready var firelight = load("res://Scenes/Fires/FireLight.tscn").instance()
var shadows = false setget set_shadows, get_shadows

func set_shadows(value):
	shadows = value
	
	get_tree().call_group("lights", "set_shadows", value)

func get_shadows():
	return shadows
########################################

# Can always toggle fullscreen, no matter what
func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

# Whether the player is currently experiencing a memory
var in_memory = false

# Variables that are global between each TreeForestWall and TreeRandom
var tree_frame_array = [1, 0, 0, 3, 1, 2, 2, 0, 1, 2, 3, 0, 1, 2] # Distribution of trees that gets cycled through
var tree_ind = 0              # Current position in tree_frame_array
var tree_nums = [0, 0, 0, 0]  # Counts for each kind of tree
