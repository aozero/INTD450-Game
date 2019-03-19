extends Node

const FADE_DURATION = 2.0

onready var tween_out = $TweenOut

onready var drone_player = $DronePlayer
onready var drone_vol = drone_player.volume_db

onready var melody_player = $MelodyPlayer
onready var melody_vol = melody_player.volume_db

onready var dying_player = $DyingPlayer
onready var dying_vol = dying_player.volume_db

func play_melody(melody):
	melody_player.stream = melody
	melody_player.play()

func stop_melody():
	tween_out.interpolate_property(melody_player, "volume_db", melody_vol, -80, FADE_DURATION, Tween.TRANS_SINE, Tween.EASE_IN, 0)
	tween_out.start()

func play_dying():
	dying_player.play()

func _on_TweenOut_tween_completed(object, key):
	object.stop()
