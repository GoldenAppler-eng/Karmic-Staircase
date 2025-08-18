extends BrainState

@export var dead_state : BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain._wants_sprint = true
	brain.set_target_position(level.staircase_top.global_position)
	
	speech_text.say("Get away from me!")
	
func exit() -> void:
	brain._wants_movement = false
	brain._wants_sprint = false

func process_physics(delta : float) -> BrainState:
	if stat_data_component.is_dead:
		return dead_state
	
	if brain.is_close_to_target():
		(owner as Node2D).visible = false
		owner.process_mode = Node.PROCESS_MODE_DISABLED
		
		return null
	
	return null
	
