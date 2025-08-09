class_name GameManager
extends Node2D

signal game_ended(all_levels_passed : bool, player_starved : bool, player_killed : bool, all_cake_eaten : bool, player_has_killed : bool, has_eaten_cake : bool, burnout : bool, all_boards_put_in_fire : bool, has_burn_board : bool, stolen_from_past : bool)

const NUMBER_OF_LEVELS : int = 7

const level_prefab : PackedScene = preload("res://scene/level.tscn")

@export var player : Player

@onready var staircase_level_manager: StaircaseLevelManager = $staircase_level_manager
@onready var level_container: Node2D = $Levels

@onready var origin: Node2D = $Constant/origin
@onready var staircase_top_marker: Node2D = $Constant/staircase_top_marker
@onready var evil_spawn_location: Node2D = $Constant/evil_spawn_location

@onready var canvas_layer: CanvasLayer = $HUD

var level_counter : int = 0

var _all_cake_eaten : bool = false
var _player_has_killed : bool = false
var _all_boards_put_in_fire : bool = false
var _stolen_from_past : bool = false

func _ready() -> void:
	create_levels()
	
	staircase_level_manager.init()
	
	staircase_level_manager.all_levels_passed.connect(_on_all_levels_passed)
	staircase_level_manager.all_cake_eaten.connect(_on_all_cake_eaten)
	staircase_level_manager.all_boards_put_in_fire.connect(_on_all_boards_put_in_fire)
	staircase_level_manager.burnout.connect(_on_burnout)
	staircase_level_manager.stolen_from_past.connect(_on_stolen_from_past)

	player.death.connect(_on_player_death)
	player.player_has_killed.connect(_on_player_has_killed)
	
func create_levels() -> void:
	for i in NUMBER_OF_LEVELS:
		create_level(level_counter)
		level_counter += 1
		
func create_level(id : int) -> void:
	var level : Level = level_prefab.instantiate()
	level.init(id, origin, staircase_top_marker, evil_spawn_location)
	level_container.add_child(level)
	level.name =  "Level" + str(id)
	
	staircase_level_manager.add_level(level)

func _on_player_has_killed() -> void:
	_player_has_killed = true

func _on_player_death(starved : bool, killed : bool, has_eaten_cake : bool) -> void:
	game_ended.emit(false, starved, killed, _all_cake_eaten, _player_has_killed, has_eaten_cake, false, _all_boards_put_in_fire, false, _stolen_from_past)
	canvas_layer.hide()

func _on_all_levels_passed() -> void:
	game_ended.emit(true, false, false, _all_cake_eaten, _player_has_killed, false, false, _all_boards_put_in_fire, false, _stolen_from_past)
	canvas_layer.hide()

func _on_burnout() -> void:
	game_ended.emit(false, false, false, false, false, false, true, _all_boards_put_in_fire, player.has_burn_board, _stolen_from_past)
	canvas_layer.hide()

func _on_all_cake_eaten() -> void:
	_all_cake_eaten = true

func _on_all_boards_put_in_fire() -> void:
	_all_boards_put_in_fire = true

func _on_stolen_from_past() -> void:
	_stolen_from_past = true
