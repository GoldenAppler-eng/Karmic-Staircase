class_name GameEndManager
extends Node

const ENDING_TEXT_DICTIONARY : Dictionary = {
	"LUST" : "Following your passion to its natural limit, it consumed you",
	"ENVY" : "No solace is found in knowing you were not the last",
	"GLUTTONY": "Filling your stomach with delights sparing no ration... Your end was ironic",
	"WRATH": "Letting your rage poison you, you succeeded at your own expense",
	"GREED": "Taking what is rightfully yours, you can rest knowing others starved",
	"SLOTH": "Putting it off until the last moment, even the last moment passed you by",
	"PRIDE": "Unwilling to demean yourself, you fell from grace",
	"LOST" : "Neither totally innocent nor guilty, you end up in the realm of the forgotten",
	"GOOD" : "Faultless in your journey, you find yourself in good riddance"
}

const ENDING_COLOR_DICTIONARY : Dictionary = {
	"LUST" : "#ff0000",
	"ENVY" : "#000000",
	"GLUTTONY" : "#000000",
	"WRATH" : "#000000",
	"GREED": "#000000",
	"SLOTH" : "#000000",
	"PRIDE" : "#000000",
	"LOST" : "#000000",
	"GOOD" : "#000000"
}

var current_game : GameManager

func get_ending_color() -> String:
	var ending : String = get_ending_result()
	
	return ENDING_COLOR_DICTIONARY[ending]
	
func get_ending_description() -> String:
	var ending : String = get_ending_result()
	
	return ENDING_TEXT_DICTIONARY[ending]
	
func get_ending_result() -> String:
	
	
	return ""

func get_ended() -> bool:
	return false
