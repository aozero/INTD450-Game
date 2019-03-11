extends Node

onready var MUSIC_TAPSHOE = load("res://Sound/Music/DadMelody.wav")

onready var drone_player = $DronePlayer
onready var melody_player = $MelodyPlayer
onready var dying_player = $DyingPlayer

func play_melody(melody):
	melody_player.stream = melody
	melody_player.play()

func stop_melody():
	melody_player.stop()

func play_dying():
	dying_player.play()
