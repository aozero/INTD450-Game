extends ColorRect

onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	next_scene()

func _input(event):
	if event.is_action_pressed("pause"):
		next_scene()

func next_scene():
	get_tree().change_scene("res://Scenes/Menus/DarkAdvisory.tscn")
