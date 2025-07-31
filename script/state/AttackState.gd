extends State

@export var idle_state : State
@export var move_state : State

var _attack_finished : bool = false

func extra_init() -> void:
	pass
	
func enter() -> void:
	_attack_finished = false
	
	get_tree().create_timer(0.5).timeout.connect( mark_attack_finished, CONNECT_ONE_SHOT)
	
func exit() -> void:
	pass	
	
func process_physics(delta : float) -> State:
	if not _attack_finished:
		return null
	
	if brain.wants_movement():
		return move_state
	else:
		return idle_state
	
	return null
	
func process_frame(delta : float) -> State:
	return null

func mark_attack_finished() -> void:
	_attack_finished = true
