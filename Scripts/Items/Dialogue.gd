extends Node

"""
 Contains the sound, text, and how long to display the text for all the dialogue in the game.

 Each item has up to 3 parts:
	SOUND: The location of the sound file that will play.
		Copy one of the existing lines and modify it to point to the sound file you want to play.
		Make sure to keep the load at the beginning, and wrap it all in (" and ")
	TEXT: The text that will appear on the screen.  
		Make sure that every text constant starts and ends with quotation marks.
		To make quotation marks in the actual text, use \" instead
	TEXT_TIME: How long in seconds the text should stay on the screen. Ignored by final items.
	MUSIC: The location of the music file that will play. Ignored by minor items
"""
var TUTORIAL_1 = {}
var TUTORIAL_2 = {}
var TUTORIAL_3 = {}
var KITCHEN_1 = {}
var KITCHEN_2 = {}
var KITCHEN_FINAL = {}
var STUDY_1 = {}
var STUDY_2 = {}
var STUDY_FINAL = {}
var BEDROOM_1 = {}
var BEDROOM_2 = {}
var BEDROOM_FINAL = {}

func _ready():
	# Tutorial Messages
	###############################
	# As soon as you start the game
	TUTORIAL_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_1.TEXT = "Use WASD to move and mouse to look."
	TUTORIAL_1.TEXT_TIME = 8
	
	# Right after moving past the campfire
	var run_button = get_action_button_text("run")
	TUTORIAL_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_2.TEXT = "Running (Hold " + run_button + ") in the forest makes a lot of noise. "
	TUTORIAL_2.TEXT_TIME = 8
	
	# At the very edge of the campfire's light
	var light_button = get_action_button_text("shoot")
	TUTORIAL_3.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_3.TEXT = "Lighting a match (" + light_button + ") will make it easier to see... and be seen."
	TUTORIAL_3.TEXT_TIME = 8
	###############################
	
	# Kitchen
	###############################
	# Cookie Jar
	KITCHEN_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	KITCHEN_1.TEXT = "Riley: Oatmeal raisin! I thought they were chocolate chip? This is a jar of LIES!"
	KITCHEN_1.TEXT_TIME = 8
	
	# Coffee Mug
	KITCHEN_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	KITCHEN_2.TEXT = "Lauren: Oh NOW you don’t like your sandwich? Come on, you would have never known it was vegan cheese if I hadn't told you. The store said it tasted exactly the same."
	KITCHEN_2.TEXT_TIME = 8
	
	# Drawing of Clubhouse
	KITCHEN_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/kitchen_memory.wav")
	KITCHEN_FINAL.TEXT = "Riley: Too slow, Jamie. If you want me to drop the ladder, you gotta give me the password."
	KITCHEN_FINAL.MUSIC = load("res://Sound/Music/KitchenMemory.wav")
	###############################
	
	# Study
	###############################
	# Ship in a Bottle
	STUDY_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	STUDY_1.TEXT = "Riley: I'm sorry, Daddy! It was an accident, I swear. I didn't think the ball would go that far."
	STUDY_1.TEXT_TIME = 8
	
	# Leather-bound Planner
	STUDY_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	STUDY_2.TEXT = "David: May 14th, 2009. Jamie (Caterpillar) and Riley's (Queen of Hearts) school play. Alice in Wonderland - school gym 4:30PM. [crossed out]. Red eye flight to Taiwan 5:40 AM. "
	STUDY_2.TEXT_TIME = 8
	
	# Tapshoe
	STUDY_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/study_memory.wav")
	STUDY_FINAL.TEXT  = "David: Jamie, get your sister to cool it would ya? I'm getting a headache."
	STUDY_FINAL.MUSIC = load("res://Sound/Music/StudyMemory.wav")
	###############################
	
	# Bedroom
	###############################
	# Ice Skate
	BEDROOM_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	BEDROOM_1.TEXT = "Riley: I th-thought... th-the ice w-was th-thick en-enough t-to skate on."
	BEDROOM_1.TEXT_TIME = 8
	
	# Small Painting Easel
	BEDROOM_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	BEDROOM_2.TEXT = "Lauren: Sweetie, I love all your art but if you don't clean this room, I'm taking all your paint and crayons away for a week."
	BEDROOM_2.TEXT_TIME = 8
	
	# Flamingo
	BEDROOM_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/bedroom_memory.wav")
	BEDROOM_FINAL.TEXT = "Riley: Jamie? I can't see you. Ouch! Oh my gosh, it's burning! Jamie, where are you? H-help!" 
	BEDROOM_FINAL.MUSIC = load("res://Sound/Music/BedroomMemory.wav")
	###############################


func get_action_button_text(action):
	var first = InputMap.get_action_list(action)[0]
	if first.is_class("InputEventMouseButton"):
		if first.button_index == BUTTON_LEFT:
			return "LMB"
		elif first.button_index == BUTTON_LEFT:
			return "RMB"
		elif first.button_index == BUTTON_MIDDLE:
			return "MMB"
		else:
			return "Unknown Mouse Button"
	else:
		return first.as_text()
