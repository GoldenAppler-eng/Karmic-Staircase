extends State

@export var move_state : State
@export var idle_state : State
@export var attack_state : State
@export var interact_state : State

func extra_init() -> void:
	pass
	
func enter() -> void:
	movement_component.set_sprinting(true)
	
func exit() -> void:
	movement_component.set_sprinting(false)
	
func process_physics(delta : float) -> State:
	if brain.wants_attack():
		return attack_state
	
	if interacter_component.are_interactables() and brain.wants_interact():
		return interact_state
	
	if not brain.wants_movement():
		return idle_state
	
	if not brain.wants_sprint():
		return move_state
	
	movement_component.move(delta, brain.get_movement_vector())
	
	return null
	
func process_frame(delta : float) -> State:
	return null
