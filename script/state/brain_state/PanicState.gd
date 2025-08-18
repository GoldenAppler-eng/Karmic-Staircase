extends BrainState

var dialogue_options : Array[String] = [
	"Noooo!",
	"Ahhhh!",
	"No...NO!",
	"Don't!",
	"Can't! Can't!"
]

@export var run_state : BrainState
@export var find_weapon_state : BrainState
@export var hunt_state : BrainState

var _finished : bool = false

func extra_init() -> void:
	pass

func enter() -> void:
	_finished = false
	speech_text.say(dialogue_options.pick_random())
	
	get_tree().create_timer(0.5).timeout.connect(mark_finished)
	
func exit() -> void:
	pass

func process_physics(delta : float) -> BrainState:
	if not _finished:
		return null
	
	if not stat_data_component.data.desperation >= GlobalConstants.FIND_WEAPON_DESPERATION_THRESHOLD:
		return run_state
	
	if pickup_item_component.is_not_holding_item():
		if level.board_pile.boards_left > 0:
			return find_weapon_state
		else:
			return run_state
	
	if not pickup_item_component.is_not_holding_item() and pickup_item_component.can_be_used_for_attack():
		return hunt_state

	return null
	
func mark_finished() -> void:
	_finished = true
