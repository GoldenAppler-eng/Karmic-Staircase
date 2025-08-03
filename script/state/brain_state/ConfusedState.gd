extends BrainState

const DESPERATION_THRESHOLD : float = 50

@export var panic_state : BrainState

var _finished : bool = false

func extra_init() -> void:
	pass

func enter() -> void:
	_finished = false
	speech_text.say("What the...")
	
	get_tree().create_timer(0.5).timeout.connect(mark_finished)
	
func exit() -> void:
	pass

func process_physics(delta : float) -> BrainState:
	if not _finished:
		return null
	
	if stat_data_component.data.desperation >= DESPERATION_THRESHOLD:
		return panic_state
	
	return null

func mark_finished() -> void:
	_finished = true
