extends "res://Scripts/Items/Interactable.gd"

export var burning = false

 # Set by child scripts
var DIALOGUE # Container with TEXT, SOUND, and MUSIC. Set by inherting classes
var BURN_ANIM_NAME = "burn"

onready var sprite = $CollisionShape/Sprite3D
onready var interactable_particles = $Particles
onready var burn_anim_player = $BurnAnimPlayer
onready var burn_audio = $BurningAudio
onready var globals = get_node("/root/Globals")

var interacted_with = false

func _ready():
	if burning:
		if globals.in_memory:
			interacted_with = true
			interactable_particles.visible = false
			sprite.material_override = load("res://Materials/FireBillboard.tres").duplicate()
			sprite.material_override.vertex_color_use_as_albedo = true
			translation.y = 0.4
			burn_anim_player.play(BURN_ANIM_NAME)
			burn_audio.play()
		else:
			visible = false

func can_interact(torch_visible):
	if burning:
		return false
	else:
		return torch_visible

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
	if not burning and not globals.in_memory:
		music_player.play()

func kill():
	queue_free()
