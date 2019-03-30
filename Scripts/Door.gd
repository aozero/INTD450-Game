extends StaticBody

onready var anim_player = $AnimationPlayer

func interact(player):
	anim_player.play("open the door")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Credits.tscn")
