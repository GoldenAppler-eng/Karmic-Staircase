extends State

@export var idle_state : State
@export var move_state : State

var _interact_finished : bool = false

func extra_init() -> void:
	pass
	
func enter() -> void:
	_interact_finished = false
	
	interacter_component.interact_with_interactables()
	get_tree().create_timer(0.5).timeout.connect(mark_interact_finished, CONNECT_ONE_SHOT)
	
func exit() -> void:
	pass	
	
func process_physics(delta : float) -> State:
	if not _interact_finished:
		return null
		
	if brain.wants_movement():
		return move_state
	else:
		return idle_state
	
	return null
	
func process_frame(delta : float) -> State:
	return null

func mark_interact_finished() -> void:
	_interact_finished = true
