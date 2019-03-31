extends ColorRect

"""
	Stamina allows the player to sprint
	Running reduces stamina over time, walking or stopping increases it
	Once the player runs out of stamina, they must wait until they reach the EXHAUSTION_MIN
	before they can sprint again.
"""

const MAX_STAMINA = 2400
const EXHAUSTION_MIN = 600
const STAMINA_STILL = 4
const STAMINA_WALKING = 2
const STAMINA_RUNNING = -6
var stamina = MAX_STAMINA
onready var stamina_bar = $StaminaBar
onready var disappear_timer = $DisappearTimer
onready var STAMINA_BAR_X_SIZE = stamina_bar.rect_size.x
onready var STAMINA_BAR_RIGHT_MARG = stamina_bar.margin_right
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
		visible = true
	elif moving:
		# Increase player stamina slightly
		increase_stamina(STAMINA_WALKING)
	else:
		# Increase player stamina
		increase_stamina(STAMINA_STILL)
	
	stamina_bar.margin_right = STAMINA_BAR_RIGHT_MARG - STAMINA_BAR_X_SIZE * (1 - float(stamina) / MAX_STAMINA)

func increase_stamina(amount):
	if stamina < MAX_STAMINA:
		stamina += amount
		
		if stamina > EXHAUSTION_MIN:
			set_exhausted(false)
		
	elif visible && disappear_timer.is_stopped():
		disappear_timer.start()

func _on_DisappearTimer_timeout():
	visible = false
