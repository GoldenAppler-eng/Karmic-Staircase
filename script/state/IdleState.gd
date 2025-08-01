extends State

@export var move_state : State
@export var attack_state : State
@export var interact_state : State
@export var use_state : State
@export var drop_state : State
@export var dead_state : State

func extra_init() -> void:
	pass
	
func enter() -> void:
	pass
	
func exit() -> void:
	pass	
	
func process_physics(delta : float) -> State:
	if hurtbox_component.is_hurt():
		return dead_state
	
	if  not pickup_item_component.is_not_holding_item() and pickup_item_component.can_be_used_for_attack() and brain.wants_attack():
		return attack_state
	
	if interacter_component.are_interactables() and pickup_item_component.is_not_holding_item() and brain.wants_interact():
		return interact_state
	
	if not pickup_item_component.is_not_holding_item() and brain.wants_use():
		return use_state
	
	if not pickup_item_component.is_not_holding_item() and brain.wants_drop():
		return drop_state
	
	if brain.wants_movement():
		return move_state
	
	return null
	
func process_frame(delta : float) -> State:
	return null
