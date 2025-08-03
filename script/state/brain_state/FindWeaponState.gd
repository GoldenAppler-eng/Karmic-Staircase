extends BrainState

@export var run_state : BrainState
@export var hunt_state : BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain._wants_sprint = true
	brain.set_target_position(level.board_pile.global_position)
	
func exit() -> void:
	brain._wants_movement = false
	brain._wants_interact = false

	brain._wants_sprint = false

func process_physics(delta : float) -> BrainState:
	if interacter_component.are_interactables() and interacter_component.get_interactables()[0].owner is BoardPile:
		brain._wants_interact = true
	
	if not pickup_item_component.is_not_holding_item() and pickup_item_component.can_be_used_for_attack():
		return hunt_state
	
	if level.board_pile.boards_left <= 0:
		return run_state
	
	return null
	
