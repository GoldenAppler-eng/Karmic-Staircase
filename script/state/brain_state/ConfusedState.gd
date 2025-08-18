extends BrainState

var dialogue_options : Array[String] = [
	"What the...?",
	"Is that...?",
	"Who are you?",
	"This isn't possible.",
	"Wait...what?"
]

@export var panic_state : BrainState

var _finished : bool = false

func extra_init() -> void:
	pass

func enter() -> void:
	_finished = false
	speech_text.say(dialogue_options.pick_random())
	
	get_tree().create_timer(1).timeout.connect(mark_finished)
	
func exit() -> void:
	pass

func process_physics(delta : float) -> BrainState:
	if not _finished:
		return null
	
	if stat_data_component.data.desperation >= GlobalConstants.PANIC_DESPERATION_THRESHOLD:
		return panic_state
	
	return null

func mark_finished() -> void:
	_finished = true
