extends Node

"""
 Contains the text for all the dialogue in the game.
 Make sure that every text constant starts and ends with quotation marks.
 To make quotation marks in the actual text, use \" instead

 **CURRENTLY YOU ACTUALLY CAN'T BOLD/ITALICIZE THINGS**
 You can make things bold or italicized or underlined etc. using BBCode, described here: 
 https://docs.godotengine.org/en/3.0/tutorials/gui/bbcode_in_richtextlabel.html
"""
var KITCHEN_1 = {}


func _ready():
	KITCHEN_1.TEXT = "Oatmeal raisin! I thought they were chocolate chip? This is a jar of LIES!"
	KITCHEN_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")


# Kitchen
###############################
# Cookie Jar
const TEXT_KITCHEN_1 = "Oatmeal raisin! I thought they were chocolate chip? This is a jar of LIES!"
var SOUND_KITCHEN_1 = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
# Coffee Mug
const TEXT_KITCHEN_2 = "Oh NOW you don’t like your sandwich? Come on, you would have never known it was vegan cheese if I hadn't told you. The store said it tasted exactly the same."
var SOUND_KITCHEN_2 = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
# Drawing of Clubhouse
const TEXT_KITCHEN_FINAL = "Too slow, Jamie. If you want me to drop the ladder, you gotta give me the password."
var SOUND_KITCHEN_FINAL = load("res://Sound/Effects/Memory/Final Items/kitchen_memory.wav")
###############################

# Study
###############################
# Ship in a Bottle
const TEXT_STUDY_1 = "I'm sorry, Daddy! It was an accident, I swear. I didn't think the ball would go that far."
var SOUND_STUDY_1 = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
# Leather-bound Planner
const TEXT_STUDY_2 = "May 14th, 2009. Jamie (Caterpillar) and Riley's (Queen of Hearts) school play. Alice in Wonderland - school gym 4:30PM. [crossed out]. Red eye flight to Taiwan 5:40 AM. "
var SOUND_STUDY_1 = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
# Tapshoe
const TEXT_STUDY_FINAL = "Jamie, get your sister to cool it would ya? I'm getting a headache."
var SOUND_STUDY_FINAL = load("res://Sound/Effects/Memory/Final Items/study_memory.wav")
###############################

# Bedroom
###############################
# Ice Skate
const TEXT_BEDROOM_1 = "I th-thought... th-the ice w-was th-thick en-enough t-to skate on."
var SOUND_BEDROOM_1 = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
# Small Painting Easel
const TEXT_BEDROOM_2 = "Sweetie, I love all your art but if you don't clean this room, I'm taking all your paint and crayons away for a week."
var SOUND_BEDROOM_2 = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
# Flamingo
const TEXT_BEDROOM_FINAL = "Jamie? I can't see you. Ouch! Oh my gosh, it's burning! Jamie, where are you? H-help!" 
var SOUND_BEDROOM_FINAL = load("res://Sound/Effects/Memory/Final Items/bedroom_memory.wav")
###############################
