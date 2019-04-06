extends StaticBody

onready var anim_player = $AnimationPlayer

onready var music_player = get_node("/root/MusicPlayer")

func interact(player):
	anim_player.play("open the door")

func _on_AnimationPlayer_animation_finished(anim_name):
	music_player.fade_out(music_player.drone_player)
	get_tree().change_scene("res://Scenes/Menus/Credits.tscn")
