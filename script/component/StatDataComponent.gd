class_name StatDataComponent
extends Node

const INITIAL_HUNGER_DEGENERATION_WAIT_TIME : float = 200000

@export var hunger_degeneration_timer : Timer
var hunger_degeneration_amount = 10

var data : StatData

func init() -> void:
	hunger_degeneration_timer.wait_time = INITIAL_HUNGER_DEGENERATION_WAIT_TIME
	owner.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA), self)
	
	data = StatData.new()
	data.resource_local_to_scene = true
	
	hunger_degeneration_timer.timeout.connect(_on_hunger_degeneration_timer_timeout)
	
func change_hunger(net_change : float) -> void:
	data.change_hunger(net_change)
	
func _on_hunger_degeneration_timer_timeout() -> void:
	data.change_hunger(-hunger_degeneration_amount)

func speed_up_hunger_degeneration_time(multiplier : float) -> void:
	hunger_degeneration_timer.wait_time = INITIAL_HUNGER_DEGENERATION_WAIT_TIME / multiplier
