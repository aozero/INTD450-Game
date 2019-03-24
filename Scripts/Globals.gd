extends Node

# OPTIONS
########################################
# Levels of forest quality.
# Fastest is ForestTree alpha scissoring on
# Prettiest is ForestTree alpha scissoring off
const FOREST_QUALITY_TEXT = ["Fastest", "Prettiest"]
var forest_material = load("res://Materials/ForestTree.tres")
var curr_forest_quality = 0

func set_forest_quality(level):
	if level == 0:
		forest_material.params_use_alpha_scissor = true
	elif level == 1:
		forest_material.params_use_alpha_scissor = false

	curr_forest_quality = level
########################################

# Whether the player is currently experiencing a memory
var in_memory = false

# Variables that are global between each TreeForestWall and TreeRandom
var tree_frame_array = [1, 0, 0, 3, 1, 2, 2, 0, 1, 2, 3, 0, 1, 2] # Distribution of trees that gets cycled through
var tree_ind = 0              # Current position in tree_frame_array
var tree_nums = [0, 0, 0, 0]  # Counts for each kind of tree
