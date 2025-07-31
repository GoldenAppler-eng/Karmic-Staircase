extends State

@export var move_state : State
@export var attack_state : State
@export var interact_state : State

func extra_init() -> void:
	pass
	
func enter() -> void:
	pass
	
func exit() -> void:
	pass	
	
func process_physics(delta : float) -> State:
	if brain.wants_attack():
		return attack_state
	
	if interacter_component.are_interactables() and brain.wants_interact():
		return interact_state
	
	if brain.wants_movement():
		return move_state
	
	return null
	
func process_frame(delta : float) -> State:
	return null
