extends State

const SPRINT_HUNGER_DEGENERATION : float = 15

@export var move_state : State
@export var idle_state : State
@export var attack_state : State
@export var interact_state : State
@export var use_state : State
@export var drop_state : State
@export var dead_state : State

func extra_init() -> void:
	pass
	
func enter() -> void:
	movement_component.set_sprinting(true)
	stat_data_component.set_hunger_degeneration_amount(SPRINT_HUNGER_DEGENERATION)
	
	animation_controller.play_animation("sprint")
	
func exit() -> void:
	movement_component.set_sprinting(false)
	stat_data_component.set_hunger_degeneration_amount()
	
func process_physics(delta : float) -> State:
	if hurtbox_component.is_hurt() or stat_data_component.is_starving():
		return dead_state
	
	if  not pickup_item_component.is_not_holding_item() and pickup_item_component.can_be_used_for_attack() and brain.wants_attack():
		return attack_state
	
	if interacter_component.are_interactables() and pickup_item_component.is_not_holding_item() and brain.wants_interact():
		return interact_state
	
	if not pickup_item_component.is_not_holding_item() and brain.wants_use():
		return use_state
	
	if not pickup_item_component.is_not_holding_item() and brain.wants_drop():
		return drop_state
	
	if not brain.wants_movement():
		return idle_state
	
	if not brain.wants_sprint():
		return move_state
	
	movement_component.move(delta, brain.get_movement_vector())
	
	return null
	
func process_frame(delta : float) -> State:
	return null
