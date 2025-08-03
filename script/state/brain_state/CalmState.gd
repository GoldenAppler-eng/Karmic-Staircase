extends BrainState

@export var find_weapon_state : BrainState
@export var run_state : BrainState
@export var dead_state : BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain._wants_sprint = false
	
	if level.cake.cake_left > 0:
		brain.set_target_position(level.cake.global_position)
	else:
		brain.set_target_position(level.fireplace.global_position)
	
func exit() -> void:
	brain._wants_movement = false
	brain._wants_interact = false
	brain._wants_use = false

func process_physics(delta : float) -> BrainState:
	if stat_data_component.is_dead:
		return dead_state
	
	if interacter_component.are_interactables() and interacter_component.get_interactables()[0].owner is Cake:
		brain._wants_interact = true
		
	if not pickup_item_component.is_not_holding_item():
		brain._wants_use = true		
	else:
		brain._wants_use = false
	
	if stat_data_component.data.hunger > 80:
		return run_state
	
	if player_vision_component.get_number_of_seen_player() > 1:
		brain.target_player = player_vision_component.get_closest_player()
		return find_weapon_state
	
	return null
	
