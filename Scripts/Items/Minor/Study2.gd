extends "res://Scripts/Items/Minor Item.gd"

onready var sprite = $CollisionShape/Sprite3D

func _ready():
	DIALOGUE = get_node("/root/Dialogue").STUDY_2

func interact(player):
	player.memory_controller.look_at_item(sprite.texture, DIALOGUE)
