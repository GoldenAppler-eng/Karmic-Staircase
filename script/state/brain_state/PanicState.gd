extends BrainState

const AGGRESIVE_DESPERATION_THRESHOLD : float = 80

@export var run_state : BrainState
@export var find_weapon_state : BrainState
@export var hunt_state : BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	speech_text.say("Argghhhhh")
	
func exit() -> void:
	pass

func process_physics(delta : float) -> BrainState:
	if not stat_data_component.data.desperation >= AGGRESIVE_DESPERATION_THRESHOLD:
		return run_state
	
	if pickup_item_component.is_not_holding_item():
		if level.board_pile.boards_left > 0:
			return find_weapon_state
		else:
			return run_state
	
	if not pickup_item_component.is_not_holding_item() and pickup_item_component.can_be_used_for_attack():
		return hunt_state

	return null
	
