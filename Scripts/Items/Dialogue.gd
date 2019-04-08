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
var SUBTITLES_SUPPORTED = ["None", "English", "Español", "Français"]
var subtitles_language = 0 setget set_subtitles_language, get_subtitles_language

func set_subtitles_language(value):
	subtitles_language = value

func get_subtitles_language():
	return subtitles_language

var INTERACT_PROMPT = {}
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
	INTERACT_PROMPT["None"] = "Press 'E' to interact"
	INTERACT_PROMPT["Español"] = "Pulsa la 'E' para interactuar"
	INTERACT_PROMPT["Français"] = "Cliquer sur ’E’ pour interagir."
	
	# Intro messages
	###############################
	INTRO_1["None"] = "Hey Jamie are you sure about this?"
	INTRO_1["Español"] = "¡Oye! Jaime ¿estás segura de esto?"
	INTRO_1["Français"] = " Eh! Jamie es-tu sûr de ça?"
	
	INTRO_2["None"] = "No, but I think I need to go back. \nI knew I would have to one day."
	INTRO_2["Español"] = "No pero yo pienso que necesito volver. \nYo sabía que tendría que hacerlo algún día."
	INTRO_2["Français"] = "Non, mais je pense que je dois y retourner. \nJe savais que je devrais le faire un jour."
	
	INTRO_3["None"] = "Yeah maybe it was inevitable but you just seemed like really skittish, like more than usual"
	INTRO_3["Español"] = "Sí, posiblemente fue inevitable \npero parecías muy nerviosa, \nmás que normal."
	INTRO_3["Français"] = "Oui, peut-être que c’était inévitable, \nmais tu semblais vraiment plus nerveux, \ncomme plus que d’habitude."
	
	INTRO_4["None"] = "I guess it’s just weird to grasp."
	INTRO_4["Español"] = "Supongo que es raro de entender."
	INTRO_4["Français"] = "Je suppose que c’est juste étrange à saisir."
	
	INTRO_5["None"] = "With Grandpa gone, everything is mine, but it’ll never feel that way"
	INTRO_5["Español"] = "Con mi abuelo ido, todos son mío pero nunca se sentirá así."
	INTRO_5["Français"] = "Avec Grandpapa parti, tout est à moi, mais ça ne se sent jamais."
	
	INTRO_6["None"] = "Are you scared? Do you want me to go with you?"
	INTRO_6["Español"] = "¿Tienes miedo? ¿Quieres que vaya contigo?"
	INTRO_6["Français"] = "Es-tu effrayé? Veux-tu que je vienne avec toi?"
	
	INTRO_7["None"] = "No, I’ll be alright. It’s like they all said."
	INTRO_7["Español"] = "No, estará bien. Es como todos dijeron."
	INTRO_7["Français"] = "Non, ça va aller. C’est comme ils ont tous dit."
	
	INTRO_8["None"] = "My fears are just in my head."
	INTRO_8["Español"] = "Mis temores están solo en mi cabeza."
	INTRO_8["Français"] = "Mes peurs sont juste dans ma tête."
	
	# Tutorial Messages
	###############################
	# As soon as you start the game
	TUTORIAL_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_1["None"] = "Use WASD to move and mouse to look."
	TUTORIAL_1["Español"] = "Usa WASD a mover y usa el ratón a mirar."
	TUTORIAL_1.TEXT_TIME = 16
	
	# Right after moving past the campfire
	TUTORIAL_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_2["None"] = "Running (Hold Shift) in the forest makes a lot of noise. "
	TUTORIAL_2["Español"] = "Correr en el bosque (Manteniendo la tecla Shift) hace mucho ruido."
	TUTORIAL_2.TEXT_TIME = 16
	
	# At the very edge of the campfire's light
	TUTORIAL_3.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	TUTORIAL_3["None"] = "Lighting a match (Left Click) will make it easier to see... and be seen."
	TUTORIAL_3["Español"] = "Encender un fósforo (tecla izquierda del ratón) hará que sea más fácil de ver… y ser visto."
	TUTORIAL_3.TEXT_TIME = 16
	###############################
	
	# Kitchen
	###############################
	# Cookie Jar
	KITCHEN_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/kitchen_cookiejar_memory.wav")
	KITCHEN_1["None"] = ""
	KITCHEN_1["English"] = "Riley: Oatmeal raisin! I thought they were chocolate chip? This jar is full of LIES!"
	KITCHEN_1["Español"] = "Riley: ¿Avena y pasas? ¡Pensé que eran pepitas de chocolate! ¡Este es un tarro de mentiras!"
	KITCHEN_1.TEXT_TIME = 8
	
	# Coffee Mug
	KITCHEN_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/kitchen_coffeemug_memory.wav")
	KITCHEN_2["None"] = ""
	KITCHEN_2["English"] = "Mom: Oh NOW you don’t like your sandwich? Come on, you would have never known it was vegan cheese if I hadn't told you. The store said it tasted exactly the same."
	KITCHEN_2["Español"] = "Mamá: Ah, ¿ahora no quieres tu sándwich? Nunca lo hubieras sabido fui queso vegano si no te hubiera dicho. La cajera dijo que el sabor fue el mismo."
	KITCHEN_2.TEXT_TIME = 10
	
	# Drawing of Clubhouse
	KITCHEN_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/kitchen_memory.wav")
	KITCHEN_FINAL["None"] = ""
	KITCHEN_FINAL["English"] = "Riley: Too slow, Jamie. If you want me to drop the ladder, you gotta give me the password."
	KITCHEN_FINAL["Español"] = "Riley: Demasiado lento, Jaime. Si tú me quieres soltar la escalera, tienes que dame la contraseña."
	KITCHEN_FINAL.MUSIC = load("res://Sound/Music/KitchenMemory.wav")
	###############################
	
	# Study
	###############################
	# Ship in a Bottle
	STUDY_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/study_shipinabottle_memory.wav")
	STUDY_1["None"] = ""
	STUDY_1["English"] = "Riley: I'm sorry, Daddy! It was an accident, I swear. I didn't think the ball would go that far."
	STUDY_1["Español"] = "Riley: ¡Lo siento, Papá! ¡Fue un accidente, prometo! No pensé que la pelota llegaría tan lejos."
	STUDY_1.TEXT_TIME = 8
	
	# Leather-bound Planner
	STUDY_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/silence.wav")
	STUDY_2["None"] = "Dad's Planner\nPress 'E' to close"
	STUDY_2["English"] = "Dad: May 14th, 2009. Jamie (Caterpillar) and Riley's (Queen of Hearts) school play. Alice in Wonderland - school gym 4:30PM. [crossed out]. Red eye flight to Taiwan 5:40 AM.\nPress 'E' to close"
	STUDY_2["Español"] = "Papá: 14 de mayo, 2009. Jaime (Oruga) y Riley (La Reina de Corazones) obra escolar. Alicia en el país de las Maravillas – gimnasio de escuela, 16:30. Vuelo nocturno a Taiwán, 5:40.\nPulsa la 'E' para cerrar"
	STUDY_2.TEXT_TIME = 12
	
	# Tapshoe
	STUDY_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/study_memory.wav")
	STUDY_FINAL["None"] = ""
	STUDY_FINAL["English"] = "Dad: Jamie, get your sister to cool it would ya? I'm getting a headache."
	STUDY_FINAL["Español"] = "Papá: Jaime, haz que tu hermana lo detenga por favor. Me duele la cabeza."
	STUDY_FINAL.MUSIC = load("res://Sound/Music/StudyMemory.wav")
	###############################
	
	# Bedroom
	###############################
	# Ice Skate
	BEDROOM_1.SOUND = load("res://Sound/Effects/Memory/Minor Items/bedroom_iceskate_memory.wav")
	BEDROOM_1["None"] = ""
	BEDROOM_1["English"] = "Riley: Jaime, watch me! Look at me! I'm a dancer."
	BEDROOM_1["Español"] = "Riley: Jaime ¡mírame! ¡Mírame, Jaime! Soy una bailarina."
	BEDROOM_1.TEXT_TIME = 8
	
	# Small Painting Easel
	BEDROOM_2.SOUND = load("res://Sound/Effects/Memory/Minor Items/bedroom_easel_memory.wav")
	BEDROOM_2["None"] = ""
	BEDROOM_2["English"] = "Mom: Sweetie, I love all of your art but if you don't clean this room, I'm taking all your paint and crayons away for a week."
	BEDROOM_2["Español"] = "Mamá: Cariña, me encanta todo tu arte, pero si no limpias esta habitación, te quitaré toda la pintura y los crayones durante una semana."
	BEDROOM_2.TEXT_TIME = 9
	
	# Flamingo
	BEDROOM_FINAL.SOUND = load("res://Sound/Effects/Memory/Final Items/bedroom_memory.wav")
	BEDROOM_FINAL["None"] = ""
	BEDROOM_FINAL["English"] = "Riley: Jamie? I can't see you. Ouch! Oh my gosh, it's burning! Jamie, where are you? H-help!" 
	BEDROOM_FINAL["Español"] = "Riley: ¡Jaime! No puedo verte. ¡Ay!¡Dios mio! Está quemando. Jaime, ¿dondé estás? ¡Ayudame!"
	BEDROOM_FINAL.MUSIC = load("res://Sound/Music/BedroomMemory.wav")
	###############################

func get_subtitles(item_dialogue):
	if item_dialogue.has(SUBTITLES_SUPPORTED[subtitles_language]):
		return item_dialogue[SUBTITLES_SUPPORTED[subtitles_language]]
	else:
		return item_dialogue[SUBTITLES_SUPPORTED[0]]

# No longer used as keys cannot be found and it is simpler for translation to hard code
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
