extends BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain.set_target_position(level.staircase_top.global_position)
	
	speech_text.say("Get away from me")
	
func exit() -> void:
	brain._wants_movement = false

func process_physics(delta : float) -> BrainState:
	return null
	
