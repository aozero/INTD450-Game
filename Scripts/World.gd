extends Spatial

onready var music_player = get_node("/root/MusicPlayer")

func _ready():
	if !music_player.drone_player.is_playing():
		music_player.fade_in(music_player.drone_player)
