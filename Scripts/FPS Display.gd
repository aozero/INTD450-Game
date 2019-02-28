extends Label

# Delay first reading so that low is more accurate
var time = 2

var high = 0
var low = 1000000
var fps = 0

func _ready():
	text = ""
	
	# TURN OFF FPS DISPLAY FOR DEMO
	set_process(false)

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
