extends BrainState

const DESIRED_ATTACK_RANGE : float = 10

@export var run_state : BrainState
@export var hunt_state : BrainState
@export var calm_state : BrainState

@export var dead_state : BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain._wants_sprint = true
	
	brain.find_target_player()
	
	speech_text.say("Get over here")
	
func exit() -> void:
	brain._wants_movement = false
	brain._wants_attack = false
	brain._wants_sprint = false

func process_physics(delta : float) -> BrainState:
	if stat_data_component.is_dead:
		return dead_state
	
	if pickup_item_component.is_not_holding_item():
		return calm_state

	if not brain.target_player:
		return hunt_state
	
	brain.find_target_player()
	
	if (brain.owner as Node2D).global_position.distance_to(brain.target_player.global_position) < DESIRED_ATTACK_RANGE:
		brain._wants_attack = true
	else:
		brain._wants_attack = false
	
	return null
	
