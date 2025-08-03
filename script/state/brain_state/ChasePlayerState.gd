extends BrainState

const DESIRED_ATTACK_RANGE : float = 20

@export var find_weapon_state : BrainState
@export var run_state : BrainState
@export var hunt_state : BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain.find_target_player()
	
	speech_text.say("Get over here")
	
func exit() -> void:
	brain._wants_movement = false

func process_physics(delta : float) -> BrainState:
	if pickup_item_component.is_not_holding_item():
		if level.board_pile.boards_left > 0:
			return find_weapon_state
			
		return run_state
		
	if not brain.target_player:
		return hunt_state
	
	brain.find_target_player()
	
	if (brain.owner as Node2D).global_position.distance_to(brain.target_player.global_position) < DESIRED_ATTACK_RANGE:
		brain._wants_attack = true
	else:
		brain._wants_attack = false
	
	return null
	
