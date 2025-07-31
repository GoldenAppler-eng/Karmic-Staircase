class_name State
extends Node

var brain : Brain
var movement_component : MovementComponent
var interacter_component : InteracterComponent
var pickup_item_component : PickupItemComponent
var stat_data_component : StatDataComponent

func init(p_brain : Brain, p_movement_component : MovementComponent, p_interacter_component : InteracterComponent, p_pickup_item_component : PickupItemComponent, p_stat_data_component : StatDataComponent) -> void:
	brain = p_brain
	movement_component = p_movement_component
	interacter_component = p_interacter_component
	pickup_item_component = p_pickup_item_component
	stat_data_component = p_stat_data_component
	
	extra_init()
	
func extra_init() -> void:
	pass
	
func enter() -> void:
	pass
	
func exit() -> void:
	pass	
	
func process_physics(delta : float) -> State:
	return null
	
func process_frame(delta : float) -> State:
	return null
