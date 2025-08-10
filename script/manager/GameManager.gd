class_name GameManager
extends Node2D

signal game_ended

const NUMBER_OF_LEVELS : int = 7

const level_prefab : PackedScene = preload("res://scene/level.tscn")

@export var player : Player

@onready var staircase_level_manager: StaircaseLevelManager = $staircase_level_manager
@onready var level_container: Node2D = $Levels

@onready var origin: Node2D = $Constant/origin
@onready var staircase_top_marker: Node2D = $Constant/staircase_top_marker
@onready var evil_spawn_location: Node2D = $Constant/evil_spawn_location

@onready var hud: CanvasLayer = $HUD

var level_counter : int = 0

func _ready() -> void:
	create_levels()
	
	staircase_level_manager.init()
	
	staircase_level_manager.all_levels_passed.connect(signal_game_end)
	staircase_level_manager.burnout.connect(signal_game_end)
	player.death.connect(signal_game_end)
	
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
	
func signal_game_end() -> void:
	game_ended.emit()
	hud.hide()
