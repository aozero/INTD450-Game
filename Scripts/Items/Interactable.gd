extends KinematicBody

const FADE_DURATION = 1.0

onready var tween_out = $TweenOut

onready var music_player = $MusicPlayer
onready var music_vol = music_player.unit_db

func fade_out_music():
	tween_out.interpolate_property(music_player, "unit_db", music_vol, music_vol - 30, FADE_DURATION, Tween.TRANS_SINE, Tween.EASE_IN, 0)
	tween_out.start()

func _on_TweenOut_tween_completed(object, key):
	music_player.stop()
	music_player.unit_db = music_vol
