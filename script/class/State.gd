class_name State
extends Node

var brain : Brain
var movement_component : MovementComponent
var interacter_component : InteracterComponent

func init(p_brain : Brain, p_movement_component : MovementComponent, p_interacter_component : InteracterComponent) -> void:
	brain = p_brain
	movement_component = p_movement_component
	interacter_component = p_interacter_component
	
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
