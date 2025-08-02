extends Control

@export var player : Player

var player_stat_data : StatData

@onready var label: Label = $Label

func _ready() -> void:
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	
	var stat_data_component : StatDataComponent = player.get_meta(stat_meta_name)
	
	player_stat_data = stat_data_component.data

func _physics_process(delta: float) -> void:
	label.text = str(player_stat_data.desperation)
