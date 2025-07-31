extends Node

signal level_changed(current_level : int)

@export var player : Player
var current_level : int:
	set(value):
		if not value == current_level:
			level_changed.emit(value) 
		
		current_level = value

@onready var label: Label = $Label

var rotation_tracker_component : RotationTrackerComponent

func _ready() -> void:	
	rotation_tracker_component = player.get_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.ROTATIONTRACKER))
	
func _physics_process(delta: float) -> void:
	current_level = rotation_tracker_component.psuedo_vertical_coordinate / 2
	label.text = str(current_level)
