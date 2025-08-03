class_name Level
extends Node2D

const recorded_player_prefab : PackedScene = preload("res://scene/players/recorded_player.tscn")

@export var level_data : LevelData

@export var origin_node : Node2D
@export var staircase_top : Node2D

@export var board_pile : BoardPile
@export var cake : Cake
@export var fireplace : Fireplace

var recorded_players : Array[RecordedPlayer]

func _init() -> void:
	disable()

func intialize_first_level_data(player : Player) -> void:
	hold_data(player)
	
	level_data.initial_boards_left = board_pile.boards_left
	level_data.initial_cake_left = cake.cake_left
	level_data.initial_fuel_level = fireplace.fuel

func initialize_data(player : Player) -> void:
	level_data.initial_player_positions.append(player.global_position)
	level_data.initial_player_vertical_coordinates.append(player.get_vertical_coordinate())
	level_data.initial_player_stats.append(player.get_stats())
	
func hold_data(player : Player) -> void:
	level_data.held_initial_player_position = player.global_position
	level_data.held_initial_vertical_coordinate = player.get_vertical_coordinate()
	level_data.held_initial_stat = player.get_stats()
		
func save_data(player : Player) -> LevelData:
	level_data.final_boards_left = board_pile.boards_left
	level_data.final_cake_left = cake.cake_left
	level_data.final_fuel_level = fireplace.fuel
	
	level_data.initial_player_positions.append(level_data.held_initial_player_position)
	level_data.initial_player_vertical_coordinates.append(level_data.held_initial_vertical_coordinate)
	level_data.initial_player_stats.append(level_data.held_initial_stat)
		
	level_data.players_recorded_steps.append(player.get_recorded_steps())
	level_data.players_recorded_items.append(player.get_recorded_items())
	
	player.clear_recorded_steps()
		
	return level_data

func load_from_data(prev_level_data : LevelData) -> void:
	level_data.initial_boards_left = prev_level_data.final_boards_left
	level_data.initial_cake_left = prev_level_data.final_cake_left
	level_data.initial_fuel_level = prev_level_data.final_fuel_level
	
func create_recorded_players() -> void:
	for index in level_data.initial_player_positions.size():
		if index < recorded_players.size():
			continue
		
		var position : Vector2 = level_data.initial_player_positions[index]
		var vertical_coordinate : float = level_data.initial_player_vertical_coordinates[index]
		var recorded_steps : Array[BrainFrameData] = level_data.players_recorded_steps[index]
		var recorded_items : Array[PickupFrameData] = level_data.players_recorded_items[index]
		
		var recorded_stats : StatData = level_data.initial_player_stats[index]
		
		var recorded_player : RecordedPlayer = recorded_player_prefab.instantiate()
		recorded_player.origin_node = origin_node
		recorded_player.set_level(self)
		
		add_child(recorded_player)
		
		recorded_player.initial_position = position
		recorded_player.set_vertical_coordinate(vertical_coordinate)
		recorded_player.set_recorded_brain_data(recorded_steps, recorded_items)
		recorded_player.set_stats(recorded_stats)
		
		recorded_players.append(recorded_player)

func load_data() -> void:
	board_pile.boards_left = level_data.initial_boards_left
	cake.cake_left = level_data.initial_cake_left
	fireplace.fuel = level_data.initial_fuel_level

func reset_recorded_players() -> void:
	for recorded_player in recorded_players:
		recorded_player.reset_player()

func disable() -> void:
	process_mode = PROCESS_MODE_DISABLED
	visible = false
	
func enable() -> void:
	process_mode = PROCESS_MODE_INHERIT
	visible = true
