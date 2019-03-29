extends ColorRect

const MAX_STAMINA = 1000
const STAMINA_GAIN = 1
const STAMINA_LOSS = -3
var stamina = MAX_STAMINA
onready var stamina_bar = $StaminaBar
onready var disappear_timer = $DisappearTimer
onready var STAMINA_BAR_X_SIZE = stamina_bar.rect_size.x
onready var STAMINA_BAR_RIGHT_MARG = stamina_bar.margin_right

func update_stamina(running):
	# Stamina system
	if running:
		# Reduce player stamina
		stamina += STAMINA_LOSS
		visible = true
	else:
		# Increase player stamina
		if stamina < MAX_STAMINA:
			stamina += STAMINA_GAIN
		elif visible && disappear_timer.is_stopped():
			disappear_timer.start()
	
	stamina_bar.margin_right = STAMINA_BAR_RIGHT_MARG - STAMINA_BAR_X_SIZE * (1 - float(stamina) / MAX_STAMINA)

func _on_DisappearTimer_timeout():
	visible = false
