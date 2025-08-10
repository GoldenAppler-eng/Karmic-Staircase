extends Node

var moksha : bool = false
var all_levels_passed : bool = false
var starved : bool = false
var killed_by_player : bool = false
var player_has_killed : bool = false
var all_cake_eaten : bool = false
var has_eaten_cake : bool = false
var burnout : bool = false
var has_burn_board : bool = false
var all_boards_burnt : bool = false
var stolen : bool = false

func reset_all_flags() -> void:
	moksha = false
	all_levels_passed = false
	starved = false
	killed_by_player = false
	all_cake_eaten = false
	player_has_killed = false
	has_eaten_cake = false
	all_boards_burnt = false
	burnout = false
	has_burn_board = false
	stolen = false
