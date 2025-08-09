class_name PlayerStatisticsHUD
extends Control

@onready var hunger_bar: TextureProgressBar = %HungerBar
@onready var desperation_bar: TextureProgressBar = %DesperationBar

var stat_data_component : StatDataComponent

func init(p_stat_data_component : StatDataComponent) -> void:
	stat_data_component = p_stat_data_component

func _physics_process(delta: float) -> void:
	if not stat_data_component:
		return
	
	if stat_data_component.is_dead:
		hide()
	
	hunger_bar.value = stat_data_component.data.hunger
	desperation_bar.value = stat_data_component.data.desperation
