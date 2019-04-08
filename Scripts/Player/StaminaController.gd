extends Node

"""
	Stamina allows the player to sprint
	Running reduces stamina over time, walking or stopping increases it
	Once the player runs out of stamina, they must wait until they reach the EXHAUSTION_MIN
	before they can sprint again.
"""

const MAX_STAMINA = 2400
const EXHAUSTION_MIN = 600
const SHADER_MAX = 1200
const STAMINA_STILL = 4
const STAMINA_WALKING = 2
const STAMINA_RUNNING = -6
var stamina = MAX_STAMINA
onready var stamina_container = $StaminaContainer
onready var stamina_bar = $StaminaContainer/StaminaBar
onready var disappear_timer = $StaminaContainer/DisappearTimer
onready var exhaustion_shader = $ExhaustionShader
onready var NORMAL_COLOR = stamina_bar.color
const EXHAUSTED_COLOR = Color(0.5, 0, 0)

var exhausted = false setget set_exhausted

func can_run():
	if stamina > 0 && not exhausted:
		return true
	else:
		return false

func set_exhausted(value):
	exhausted = value
	
	if value:
		stamina_bar.color = EXHAUSTED_COLOR
	else:
		stamina_bar.color = NORMAL_COLOR

func update_stamina(moving, running):
	# Stamina system
	if running:
		# Reduce player stamina
		stamina += STAMINA_RUNNING
		if stamina <= 0:
			set_exhausted(true)
		stamina_container.visible = true
	elif moving:
		# Increase player stamina slightly
		increase_stamina(STAMINA_WALKING)
	else:
		# Increase player stamina
		increase_stamina(STAMINA_STILL)
	
	# Stamina bar changes to reflect stamina
	stamina_bar.rect_size.x = (stamina_container.rect_size.x - 20) * (float(stamina) / MAX_STAMINA)
	
	# Exhaustion shader appears when below SHADER_MAX
	if stamina < SHADER_MAX:
		exhaustion_shader.modulate.a = float(SHADER_MAX - stamina) / SHADER_MAX
	else:
		exhaustion_shader.modulate.a = 0

func increase_stamina(amount):
	if stamina < MAX_STAMINA:
		stamina += amount
		
		if stamina > EXHAUSTION_MIN:
			set_exhausted(false)
		
	elif stamina_container.visible && disappear_timer.is_stopped():
		disappear_timer.start()

func _on_DisappearTimer_timeout():
	stamina_container.visible = false
