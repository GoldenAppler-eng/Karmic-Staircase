extends BrainState

@export var chase_player_state : BrainState
@export var dead_state : BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain.set_target_position(level.staircase_top.global_position)
	
	speech_text.say("Where are you")
	
func exit() -> void:
	brain._wants_movement = false

func process_physics(delta : float) -> BrainState:
	if stat_data_component.is_dead:
		return dead_state
	
	
	if player_vision_component.get_number_of_seen_player() > 0:
		brain.target_player = player_vision_component.get_closest_player()
		return chase_player_state
	
	return null
	
