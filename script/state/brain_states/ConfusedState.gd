extends BrainState

const DESPERATION_THRESHOLD : float = 50

@export var panic_state : BrainState

func extra_init() -> void:
	pass

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func process_physics(delta : float) -> BrainState:
	if stat_data_component.data.desperation >= DESPERATION_THRESHOLD:
		return panic_state
	
	return null
