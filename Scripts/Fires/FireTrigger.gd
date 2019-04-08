extends Spatial

onready var music_player = get_node("/root/MusicPlayer")
onready var DRONE_VOL_1 = music_player.drone_vol + 2
onready var DRONE_VOL_2 = music_player.drone_vol + 4
onready var DRONE_VOL_3 = music_player.drone_vol + 6
onready var DRONE_VOL_4 = music_player.drone_vol + 8
onready var VOL_CHANGE_TIME = 2

onready var ft1 = $FireTrigger
onready var ft2 = $FireTrigger2
onready var ft3 = $FireTrigger3
onready var ft4 = $FireTrigger4

func _on_FireTrigger_body_entered(body):
	if body.get_class() == "Player":
		for n in ft1.get_children():
			n.visible = true
		music_player.change_volume(music_player.drone_player, DRONE_VOL_1, VOL_CHANGE_TIME)

func _on_FireTrigger2_body_entered(body):
	if body.get_class() == "Player":
		for n in ft2.get_children():
			n.visible = true
		ft2.visible = true
	music_player.change_volume(music_player.drone_player, DRONE_VOL_2, VOL_CHANGE_TIME)

func _on_FireTrigger3_body_entered(body):
	if body.get_class() == "Player":
		for n in ft3.get_children():
			n.visible = true
		ft1.visible = false
	music_player.change_volume(music_player.drone_player, DRONE_VOL_3, VOL_CHANGE_TIME)

func _on_FireTrigger4_body_entered(body):
	if body.get_class() == "Player":
		for n in ft4.get_children():
			n.visible = true
		ft2.visible = false
	music_player.change_volume(music_player.drone_player, DRONE_VOL_4, VOL_CHANGE_TIME)
