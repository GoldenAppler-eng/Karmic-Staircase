class_name StateMachine
extends Node

@export var initial_state : State
var current_state : State

func init(p_brain : Brain, p_animation_controller : AnimationController, p_movement_component : MovementComponent, p_interacter_component : InteracterComponent, p_pickup_item_component : PickupItemComponent, p_stat_data_component : StatDataComponent, p_hurtbox_component : HurtboxComponent) -> void:
	for state in get_children():
		(state as State).init(p_brain, p_animation_controller, p_movement_component, p_interacter_component, p_pickup_item_component, p_stat_data_component, p_hurtbox_component)
		
	change_state(initial_state)	
		
func change_state(next_state : State) -> void:
	if current_state:
		current_state.exit()
		
	current_state = next_state
	current_state.enter()

func process_physics(delta : float) -> void:
	var next_state : State = current_state.process_physics(delta)
	
	if next_state:
		change_state(next_state)
	
func process_frame(delta : float) -> void:
	var next_state : State = current_state.process_frame(delta)
	
	if next_state:
		change_state(next_state)

func reset_state_machine() -> void:
	change_state(initial_state)

func set_brain(p_brain : Brain) -> void:
	for state in get_children():
		(state as State).set_brain(p_brain)
		
