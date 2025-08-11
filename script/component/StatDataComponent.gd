class_name StatDataComponent
extends Node

signal desperation_changed(net_change : float)
signal hunger_changed(net_change : float)

const INITIAL_HUNGER_DEGENERATION_WAIT_TIME : float = 2
const DEFAULT_HUNGER_DEGENERATION_AMOUNT : float = 1

@export var hunger_degeneration_timer : Timer
var hunger_degeneration_amount = DEFAULT_HUNGER_DEGENERATION_AMOUNT

var data : StatData

var is_dead : bool = false

func init() -> void:
	hunger_degeneration_timer.wait_time = INITIAL_HUNGER_DEGENERATION_WAIT_TIME
	owner.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA), self)
	
	data = StatData.new()
	data.resource_local_to_scene = true
	
	hunger_degeneration_timer.timeout.connect(_on_hunger_degeneration_timer_timeout)

func is_starving() -> bool:
	return data.hunger == 0
	
func change_hunger(net_change : float) -> void:
	data.change_hunger(net_change)
		
	hunger_changed.emit(net_change)

func change_desperation(net_change : float) -> void:
	data.change_desperation(net_change)
	desperation_changed.emit(net_change)

func set_hunger_degeneration_amount(amount : float = DEFAULT_HUNGER_DEGENERATION_AMOUNT) -> void:
	hunger_degeneration_amount = amount

func _on_hunger_degeneration_timer_timeout() -> void:
	data.change_hunger(-hunger_degeneration_amount)
