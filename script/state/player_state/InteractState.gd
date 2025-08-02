extends State

@export var idle_state : State
@export var move_state : State

var _interact_finished : bool = false

func extra_init() -> void:
	animation_controller.animation_finished.connect(_on_animation_finished)
	
func enter() -> void:
	_interact_finished = false
	animation_controller.play_animation("use")
		
	interacter_component.interact_with_interactables()
	
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

func _on_animation_finished(anim_name : StringName) -> void:
	mark_interact_finished()
