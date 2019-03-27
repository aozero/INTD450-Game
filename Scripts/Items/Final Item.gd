extends "res://Scripts/Items/Interactable.gd"

export var burning = false

 # Set by child scripts
var DIALOGUE # Container with TEXT, SOUND, and MUSIC. Set by inherting classes

onready var sprite = $CollisionShape/Sprite3D
onready var interactable_particles = $Particles
onready var burn_anim = $BurnAnim

var interacted_with = false

func _ready():
	if burning:
		interacted_with = true
		interactable_particles.visible = false
		sprite.material_override = load("res://Materials/FireBillboard.tres").duplicate()
		translation.y = 0.3
		burn_anim.play("burn")

func interact(player):
	if !interacted_with:
		fade_out_music()
		player.start_final_memory(self)
		interacted_with = true

# Called after the memory finished
# Override to do things like switch the scene
func after_memory():
	kill()

func _on_Timer_timeout():
	music_player.play()

func kill():
	queue_free()
