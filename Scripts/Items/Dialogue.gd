extends Node

"""
 Contains the sound, text, and how long to display the text for all the dialogue in the game.
 Make sure that every text constant starts and ends with quotation marks.
 To make quotation marks in the actual text, use \" instead

 Each item has up to 3 parts:
	SOUND: The location of the sound file that will play 
	TEXT: The text that will appear on the screen 
	LENGTH: How long in seconds the text should stay on the screen. Length is ignored by final items.
	MUSIC: The location of the music file that will play. Music is ignored by minor items
"""
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
	# Kitchen
	###############################
	# Cookie Jar
	KITCHEN_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	KITCHEN_1.TEXT = "Oatmeal raisin! I thought they were chocolate chip? This is a jar of LIES!"
	KITCHEN_1.LENGTH = 8
	# Coffee Mug
	KITCHEN_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	KITCHEN_2.TEXT = "Oh NOW you don’t like your sandwich? Come on, you would have never known it was vegan cheese if I hadn't told you. The store said it tasted exactly the same."
	KITCHEN_2.LENGTH = 8
	# Drawing of Clubhouse
	KITCHEN_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/kitchen_memory.wav")
	KITCHEN_FINAL.TEXT = "Too slow, Jamie. If you want me to drop the ladder, you gotta give me the password."
	KITCHEN_FINAL.MUSIC = load("res://Sound/Music/KitchenMemory.wav")
	###############################
	
	# Study
	###############################
	# Ship in a Bottle
	STUDY_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	STUDY_1.TEXT = "I'm sorry, Daddy! It was an accident, I swear. I didn't think the ball would go that far."
	STUDY_1.LENGTH = 8
	# Leather-bound Planner
	STUDY_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	STUDY_2.TEXT = "May 14th, 2009. Jamie (Caterpillar) and Riley's (Queen of Hearts) school play. Alice in Wonderland - school gym 4:30PM. [crossed out]. Red eye flight to Taiwan 5:40 AM. "
	STUDY_2.LENGTH = 8
	# Tapshoe
	STUDY_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/study_memory.wav")
	STUDY_FINAL.TEXT  = "Jamie, get your sister to cool it would ya? I'm getting a headache."
	STUDY_FINAL.MUSIC = load("res://Sound/Music/StudyMemory.wav")
	###############################
	
	# Bedroom
	###############################
	# Ice Skate
	BEDROOM_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	BEDROOM_1.TEXT = "I th-thought... th-the ice w-was th-thick en-enough t-to skate on."
	BEDROOM_1.LENGTH = 8
	# Small Painting Easel
	BEDROOM_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	BEDROOM_2.TEXT = "Sweetie, I love all your art but if you don't clean this room, I'm taking all your paint and crayons away for a week."
	BEDROOM_2.LENGTH = 8
	# Flamingo
	BEDROOM_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/bedroom_memory.wav")
	BEDROOM_FINAL.TEXT = "Jamie? I can't see you. Ouch! Oh my gosh, it's burning! Jamie, where are you? H-help!" 
	BEDROOM_FINAL.MUSIC = load("res://Sound/Music/BedroomMemory.wav")
	###############################
