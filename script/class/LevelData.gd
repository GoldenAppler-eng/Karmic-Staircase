class_name LevelData
extends Resource

@export var level_id : int = 0

var initial_fuel_level : float = 0
var initial_cake_left : int = 0
var initial_boards_left : int = 0

var held_initial_player_position : Vector2
var held_initial_vertical_coordinate : float

var initial_player_positions : Array[Vector2]
var initial_player_vertical_coordinates : Array[float]

var players_recorded_steps : Array

var final_fuel_level : float = 0
var final_cake_left : float = 0
var final_boards_left : float = 0
