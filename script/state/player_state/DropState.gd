extends State

const DROP_ITEM_DESPERATION : float = 10

@export var idle_state : State
@export var move_state : State

var _drop_finished : bool = false

func extra_init() -> void:
	pass
	
func enter() -> void:
	pickup_item_component.drop_item()
	
	_drop_finished = false
	get_tree().create_timer(0.5).timeout.connect(mark_drop_finished, CONNECT_ONE_SHOT)
	
func exit() -> void:
	stat_data_component.change_desperation(DROP_ITEM_DESPERATION)
	
func process_physics(delta : float) -> State:
	if not _drop_finished:
		return null
		
	if brain.wants_movement():
		return move_state
	else:
		return idle_state
	
	return null
	
func process_frame(delta : float) -> State:
	return null

func mark_drop_finished() -> void:
	_drop_finished = true
