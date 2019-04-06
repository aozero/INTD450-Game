extends Node

"""
 Contains the sound, text, and how long to display the text for all the dialogue in the game.

 Each item can have different parts, such as :
	SOUND: The location of the sound file that will play.
		Copy one of the existing lines and modify it to point to the sound file you want to play.
		Make sure to keep the load at the beginning, and wrap it all in (" and ")
	TEXT_TIME: How long in seconds the text should stay on the screen. Ignored by final items.
	MUSIC: The location of the music file that will play. Ignored by minor items
SUBTITLES PARTS:
	Make sure that every text constant starts and ends with quotation marks.
	To make quotation marks in the actual text, use \" instead
	
	None: The English text that will appear on the screen when subtitles are turned off. 
		Usually blank, except for items that always display text.
	English: The English text that will appear on the screen when subtitles are turned on. 
		Every item should have this, except items that always display text, and have their text in None.
	
	
To add a new language, for each TEXT, also add a new part to that item, such as 
TUTORIAL_1.None = "Use WASD to move and mouse to look."
TUTORIAL_1.Spanish = "Usé el traductor de google para esto."
"""
var SUBTITLES_SUPPORTED = ["None", "English"]
var subtitles_language = 0 setget set_subtitles_language, get_subtitles_language

func set_subtitles_language(value):
	subtitles_language = value

func get_subtitles_language():
	return subtitles_language

var INTRO_1 = {}
var INTRO_2 = {}
var INTRO_3 = {}
var INTRO_4 = {}
var INTRO_5 = {}
var INTRO_6 = {}
var INTRO_7 = {}
var INTRO_8 = {}
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
	# Intro messages
	###############################
	INTRO_1.None = "Hey Jamie are you sure about this?"
	
	INTRO_2.None = "No, but I think I need to go back. \n I knew I would have to one day."
	
	INTRO_3.None = "Yeah maybe it was inevitable but you just seemed like really skittish, like more than usual"
	
	INTRO_4.None = "I guess it’s just weird to grasp."
	
	INTRO_5.None = "With Grandpa gone, everything is mine, but it’ll never feel that way"
	
	INTRO_6.None = "Are you scared? Do you want me to go with you?"
	
	INTRO_7.None = "No, I’ll be alright. It’s like they all said."
	
	INTRO_8.None = "My fears are just in my head."
	
	# Tutorial Messages
	###############################
	# As soon as you start the game
	TUTORIAL_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_1.None = "Use WASD to move and mouse to look."
	TUTORIAL_1.TEXT_TIME = 16
	
	# Right after moving past the campfire
	var run_button = get_action_button_text("run")
	TUTORIAL_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_2.None = "Running (Hold " + run_button + ") in the forest makes a lot of noise. "
	TUTORIAL_2.TEXT_TIME = 16
	
	# At the very edge of the campfire's light
	var light_button = get_action_button_text("shoot")
	TUTORIAL_3.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_3.None = "Lighting a match (" + light_button + ") will make it easier to see... and be seen."
	TUTORIAL_3.TEXT_TIME = 16
	###############################
	
	# Kitchen
	###############################
	# Cookie Jar
	KITCHEN_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/kitchen_cookiejar_memory.wav")
	KITCHEN_1.None = ""
	KITCHEN_1.English = "Riley: Oatmeal raisin! I thought they were chocolate chip? This is jar is full of LIES!"
	KITCHEN_1.TEXT_TIME = 8
	
	# Coffee Mug
	KITCHEN_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/kitchen_coffeemug_memory.wav")
	KITCHEN_2.None = ""
	KITCHEN_2.English = "Mom: Oh NOW you don’t like your sandwich? Come on, you would have never known it was vegan cheese if I hadn't told you. The store said it tasted exactly the same."
	KITCHEN_2.TEXT_TIME = 10
	
	# Drawing of Clubhouse
	KITCHEN_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/kitchen_memory.wav")
	KITCHEN_FINAL.None = ""
	KITCHEN_FINAL.English = "Riley: Too slow, Jamie. If you want me to drop the ladder, you gotta give me the password."
	KITCHEN_FINAL.MUSIC = load("res://Sound/Music/KitchenMemory.wav")
	###############################
	
	# Study
	###############################
	# Ship in a Bottle
	STUDY_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/study_shipinabottle_memory.wav")
	STUDY_1.None = ""
	STUDY_1.English = "Riley: I'm sorry, Daddy! It was an accident, I swear. I didn't think the ball would go that far."
	STUDY_1.TEXT_TIME = 8
	
	# Leather-bound Planner
	STUDY_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	STUDY_2.None = "Dad: May 14th, 2009. Jamie (Caterpillar) and Riley's (Queen of Hearts) school play. Alice in Wonderland - school gym 4:30PM. [crossed out]. Red eye flight to Taiwan 5:40 AM. "
	STUDY_2.TEXT_TIME = 12
	
	# Tapshoe
	STUDY_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/study_memory.wav")
	STUDY_FINAL.None = ""
	STUDY_FINAL.English  = "Dad: Jamie, get your sister to cool it would ya? I'm getting a headache."
	STUDY_FINAL.MUSIC = load("res://Sound/Music/StudyMemory.wav")
	###############################
	
	# Bedroom
	###############################
	# Ice Skate
	BEDROOM_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/bedroom_iceskate_memory.wav")
	BEDROOM_1.None = ""
	BEDROOM_1.English = "Riley: Jamie, watch me! Look at me, I'm a dancer!"
	BEDROOM_1.TEXT_TIME = 8
	
	# Small Painting Easel
	BEDROOM_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/bedroom_easel_memory.wav")
	BEDROOM_2.None = ""
	BEDROOM_2.English = "Mom: Sweetie, I love all of your art but if you don't clean this room, I'm taking all your paint and crayons away for a week."
	BEDROOM_2.TEXT_TIME = 9
	
	# Flamingo
	BEDROOM_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/bedroom_memory.wav")
	BEDROOM_FINAL.None = ""
	BEDROOM_FINAL.English = "Riley: Jamie? I can't see you. Ouch! Oh my gosh, it's burning! Jamie, where are you? H-help!" 
	BEDROOM_FINAL.MUSIC = load("res://Sound/Music/BedroomMemory.wav")
	###############################

func get_subtitles(item_dialogue):
	if item_dialogue.has(SUBTITLES_SUPPORTED[subtitles_language]):
		return item_dialogue[SUBTITLES_SUPPORTED[subtitles_language]]
	else:
		return item_dialogue[SUBTITLES_SUPPORTED[0]]

func get_action_button_text(action):
	var first = InputMap.get_action_list(action)[0]
	if first.is_class("InputEventMouseButton"):
		if first.button_index == BUTTON_LEFT:
			return "Left Click"
		elif first.button_index == BUTTON_LEFT:
			return "Right Click"
		elif first.button_index == BUTTON_MIDDLE:
			return "MMB"
		else:
			return "Unknown Mouse Button"
	else:
		return first.as_text()
