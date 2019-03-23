extends Node

const INTRO_DURATION = 24.0
const FADE_DURATION = 2.0

onready var tween_in = $TweenIn
onready var tween_out = $TweenOut

onready var drone_player = $DronePlayer
onready var drone_vol = drone_player.volume_db
onready var melody_player = $MelodyPlayer
onready var melody_vol = melody_player.volume_db
onready var dying_player = $DyingPlayer
onready var dying_vol = dying_player.volume_db

func stop_drone():
	drone_player.stop()

func start_drone_intro():
	drone_player.volume_db = -80
	drone_player.play()
	tween_in.interpolate_property(drone_player, "volume_db", -80, drone_vol + 5, INTRO_DURATION, Tween.TRANS_SINE, Tween.EASE_IN, 0)
	tween_in.start()

func play_melody(melody):
	melody_player.volume_db = melody_vol
	melody_player.stream = melody
	melody_player.play()

func stop_melody():
	tween_out.interpolate_property(melody_player, "volume_db", melody_vol, -80, FADE_DURATION, Tween.TRANS_SINE, Tween.EASE_IN, 0)
	tween_out.start()

func play_dying():
	dying_player.volume_db = dying_vol
	dying_player.play()

func _on_TweenOut_tween_completed(object, key):
	object.stop()

func _on_TweenIn_tween_completed(object, key):
	tween_in.interpolate_property(drone_player, "volume_db", drone_player.volume_db, drone_vol, FADE_DURATION, Tween.TRANS_SINE, Tween.EASE_IN, 0)
	tween_in.start()
