class_name GameEndManager
extends Node

const TOTAL_ENDINGS : int = 10

enum ENDINGS { LUST, ENVY, GLUTTONY, WRATH, GREED, SLOTH, PRIDE, LOST, GOOD, MOKSHA }

const ENDING_TEXT_DICTIONARY : Dictionary = {
	ENDINGS.LUST : "Following your passion to its natural limit, it consumed you",
	ENDINGS.ENVY : "No solace is found in knowing you were not the last",
	ENDINGS.GLUTTONY: "Filling your stomach with delights sparing no ration... Your end was ironic",
	ENDINGS.WRATH : "Letting your rage poison you, you succeeded at your own expense",
	ENDINGS.GREED: "Taking what is rightfully yours, you can rest knowing others starved",
	ENDINGS.SLOTH : "Putting it off until the last moment, even the last moment passed you by",
	ENDINGS.PRIDE : "Unwilling to demean yourself, you fell from grace",
	ENDINGS.LOST : "Neither totally innocent nor guilty, you end up in the realm of the forgotten",
	ENDINGS.GOOD : "Faultless in your journey, you find yourself empty inside",
	ENDINGS.MOKSHA : "Realizing your faults, you escape the infinity of the karmic staircase"
}

const ENDING_COLOR_DICTIONARY : Dictionary = {
	ENDINGS.LUST : "#d95763",
	ENDINGS.ENVY : "#37846e",
	ENDINGS.GLUTTONY : "#d9a066",
	ENDINGS.WRATH : "#ac3232",
	ENDINGS.GREED : "#6abe30",
	ENDINGS.SLOTH : "#696a6a",
	ENDINGS.PRIDE : "#9300cc",
	ENDINGS.LOST : "#9badb7",
	ENDINGS.GOOD : "#fbf236",
	ENDINGS.MOKSHA : "#ffffff"
}

var current_game : GameManager

var _game_ended : bool = false

var endings_found : Dictionary = {}

func _init() -> void:
	for ending in ENDINGS:
		endings_found[ending] = false

func set_game(game : GameManager) -> void:
	current_game = game
	current_game.game_ended.connect(_on_game_ended)

func start_game(game : GameManager) -> void:
	kill_game()
	set_game(game)

func kill_game() -> void:
	_game_ended = false
	
	GlobalFlags.reset_all_flags()
	
	if current_game:
		current_game.game_ended.disconnect(_on_game_ended)
	
	current_game = null

func _on_game_ended() -> void:
	_game_ended = true
	
func get_ending_color(ending : int) -> String:
	return ENDING_COLOR_DICTIONARY[ending]
	
func get_ending_description(ending : int) -> String:
	return ENDING_TEXT_DICTIONARY[ending]

func get_ending_name(ending : int) -> String:
	return ENDINGS.keys()[ending]

func get_ending_result() -> int:	
	var ending : int = ENDINGS.LOST
	
	if GlobalFlags.all_levels_passed:
		if GlobalFlags.player_has_killed:
			ending = ENDINGS.WRATH
		elif GlobalFlags.stolen:
			ending = ENDINGS.GREED
		else:
			ending = ENDINGS.GOOD
	elif GlobalFlags.burnout:
		if GlobalFlags.all_boards_burnt:
			ending = ENDINGS.LUST
		elif not GlobalFlags.has_burn_board:
			ending = ENDINGS.SLOTH
	elif GlobalFlags.starved:
		if GlobalFlags.all_cake_eaten:
			ending = ENDINGS.GLUTTONY
		elif not GlobalFlags.has_eaten_cake:
			ending = ENDINGS.PRIDE
	elif GlobalFlags.killed_by_player:
		ending = ENDINGS.ENVY

	endings_found[ending] = true
	return ending	

func get_ended() -> bool:
	return _game_ended

func get_number_of_endings_found() -> int:
	var number_of_endings_found : int = 0;
	
	for found in endings_found.values():
		if found:
			number_of_endings_found += 1
	
	return number_of_endings_found
