extends Node

signal level_changed(current_level : int)

const EVIL_SPAWN_DESPERATION_THRESHOLD : float = 90

@export var player : Player
@export var ambient_footstep_sfx_player : AudioStreamPlayer2D

var current_level : int:
	set(value):
		if not value == current_level:
			level_changed.emit(value)
			change_level(current_level, value) 
		
		current_level = value

@onready var label: Label = $Label

@export var level_list : Array[Level]

var rotation_tracker_component : RotationTrackerComponent

func _ready() -> void:	
	rotation_tracker_component = player.get_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.ROTATIONTRACKER))
	
	level_list[0].enable()
	level_list[0].intialize_first_level_data(player)
	
func _physics_process(delta: float) -> void:
	current_level = rotation_tracker_component.psuedo_vertical_coordinate / 2
	label.text = str(current_level)

func load_next_level(level_to_load : int) -> void:
	var previous_level : int = level_to_load - 1
	var saved_data : LevelData = level_list[previous_level].save_data(player)
	
	level_list[level_to_load].hold_data(player)
	
	level_list[level_to_load].load_from_data(saved_data)
	level_list[level_to_load].load_data()
	
	level_list[previous_level].create_recorded_players()
	
	if player.get_desperation_level() > EVIL_SPAWN_DESPERATION_THRESHOLD:
		level_list[level_to_load].create_evil_player()
	
	level_list[previous_level].disable()
	level_list[level_to_load].enable()
	
func load_previous_level(level_to_load : int) -> void:	
	var next_level : int = level_to_load + 1
	
	player.clear_recorded_steps()
	
	level_list[level_to_load].load_data()
	level_list[level_to_load].hold_data(player)
	level_list[level_to_load].reset_recorded_players()
	
	level_list[level_to_load].enable()
	level_list[next_level].disable()

func change_level(previous_level : int, new_level : int) -> void:
	if previous_level < new_level:
		load_next_level(new_level)
		ambient_footstep_sfx_player.play()
		print("LOADING NEXT LEVEL")
	
	if previous_level > new_level:
		load_previous_level(new_level)
		print("LOADING PREVIOUS LEVEL")
