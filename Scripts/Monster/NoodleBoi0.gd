extends "res://Scripts/Monster/NoodleBoi.gd"

# boi stands still until activated, then runs between waypoints and disappears
# Noodle boi only appears one time on each level, even if the play dies and comes back

onready var globals = get_node("/root/Globals")

func _ready():
	print("0")
	activated = globals.noodle_boi_activated[0]
	._ready()

# Noodle boi only appears one time on each level, even if the play dies and comes back
# Set the the correct variable in global to tell noodle boi to not appear again in that level
func set_global_activation():
	globals.noodle_boi_activated[0] = true