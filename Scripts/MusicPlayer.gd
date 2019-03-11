extends Node

const QUIET = -50
const NORMAL = -40
const LOUD = -20

onready var MUSIC_TAPSHOE = load("res://Sound/Music/DadMelody.wav")

onready var drone_player = $DronePlayer
onready var melody_player = $MelodyPlayer

func play_melody(melody, volume):
	melody_player.stream = melody
	melody_player.volume_db = volume
	melody_player.play()

func stop_melody():
	melody_player.stop()
