extends ColorRect

onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Menus/DarkAdvisory.tscn")
