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
	"LUST" : "#d95763",
	"ENVY" : "#37846e",
	"GLUTTONY" : "#d9a066",
	"WRATH" : "#ac3232",
	"GREED": "#6abe30",
	"SLOTH" : "#696a6a",
	"PRIDE" : "#9300cc",
	"LOST" : "#9badb7",
	"GOOD" : "#fbf236"
}

var current_game : GameManager

var _game_ended : bool = false

var _all_levels_passed : bool = false
var _starved : bool = false
var _killed_by_player : bool = false
var _player_has_killed : bool = false
var _all_cake_eaten : bool = false
var _has_eaten_cake : bool = false
var _burnout : bool = false
var _has_burn_board : bool = false
var _all_boards_burnt : bool = false
var _stolen : bool = false

func set_game(game : GameManager) -> void:
	current_game = game
	current_game.game_ended.connect(_on_game_ended)

func start_game(game : GameManager) -> void:
	kill_game()
	set_game(game)

func kill_game() -> void:
	_game_ended = false
	
	_all_levels_passed = false
	_starved = false
	_killed_by_player = false
	_all_cake_eaten = false
	_player_has_killed = false
	_has_eaten_cake = false
	_all_boards_burnt = false
	_burnout = false
	_has_burn_board = false
	_stolen = false
	
	if current_game:
		current_game.game_ended.disconnect(_on_game_ended)
	
	current_game = null

func _on_game_ended(all_levels_passed : bool, starved : bool, killed_by_player : bool, all_cake_eaten : bool, player_has_killed : bool, has_eaten_cake : bool,  burnout : bool, all_boards_put_in_fire : bool, has_burn_board : bool, stolen : bool) -> void:
	_game_ended = true
	
	_all_levels_passed = all_levels_passed
	_starved = starved
	_killed_by_player = killed_by_player
	_all_cake_eaten = all_cake_eaten
	_player_has_killed = player_has_killed
	_has_eaten_cake = has_eaten_cake
	_has_burn_board = has_burn_board
	_burnout = burnout
	_all_boards_burnt = all_boards_put_in_fire
	_stolen = stolen
	
func get_ending_color() -> String:
	var ending : String = get_ending_result()
	
	return ENDING_COLOR_DICTIONARY[ending]
	
func get_ending_description() -> String:
	var ending : String = get_ending_result()
	
	return ENDING_TEXT_DICTIONARY[ending]
	
func get_ending_result() -> String:	
	if _all_levels_passed:
		if _player_has_killed:
			return "WRATH"
		
		if _stolen:
			return "GREED"
		
		return "GOOD"
		
	if _burnout:
		if _all_boards_burnt:
			return "LUST"
		
		if not _has_burn_board:
			return "SLOTH"
		
	if _starved:
		if _all_cake_eaten:
			return "GLUTTONY"
		
		if not _has_eaten_cake:
			return "PRIDE"
		
	if _killed_by_player:
		return "ENVY"
	
	return "LOST"

func get_ended() -> bool:
	return _game_ended
