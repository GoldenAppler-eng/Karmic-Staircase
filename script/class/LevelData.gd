class_name LevelData
extends Resource

@export var level_id : int = 0

@export var initial_fuel_level : float = 0
@export var initial_cake_left : int = 0
@export var initial_boards_left : int = 0

@export var held_initial_player_position : Vector2
@export var held_initial_vertical_coordinate : float
@export var held_initial_stat : StatData

@export var initial_player_positions : Array[Vector2]
@export var initial_player_vertical_coordinates : Array[float]
@export var initial_player_stats : Array[StatData]

@export var players_recorded_steps : Array
@export var players_recorded_items : Array

@export var final_fuel_level : float = 0
@export var final_cake_left : float = 0
@export var final_boards_left : float = 0

@export var initial_boards_used_in_fire : int = 0
@export var boards_used_in_fire : int = 0

@export var initialized : bool = false
