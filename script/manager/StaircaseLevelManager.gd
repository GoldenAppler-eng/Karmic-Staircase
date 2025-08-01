extends Node

signal level_changed(current_level : int)

@export var player : Player

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
		print("LOADING NEXT LEVEL")
	
	if previous_level > new_level:
		load_previous_level(new_level)
		print("LOADING PREVIOUS LEVEL")
