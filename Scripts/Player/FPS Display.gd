extends Label

# Delay first reading so that low is more accurate
var time = 2

var high = 0
var low = 1000000
var fps = 0

func _ready():
	text = ""
	
	visible = false

func _input(event):
	if event.is_action_pressed("toggle_fps"):
		visible = !visible

func _process(delta):
	if (time > 0):
		time -= delta
		
	fps = Engine.get_frames_per_second()
	if (fps > high):
		high = fps
	if (time <= 0):
		if (fps < low):
			low = fps
	text = "FPS: " + str(fps) + "\nHigh: " + str(high) + "\nLow: " + str(low) + "\nDrawn: " + str(Engine.get_frames_drawn())
