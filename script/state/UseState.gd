extends State

@export var idle_state : State
@export var move_state : State

var _use_finished : bool = false

func extra_init() -> void:
	animation_controller.animation_finished.connect(_on_animation_finished)
	
func enter() -> void:
	_use_finished = false
	animation_controller.play_animation("use")

	pickup_item_component.use_item()	
	
func exit() -> void:
	pass	
	
func process_physics(delta : float) -> State:
	if not _use_finished:
		return null
		
	if brain.wants_movement():
		return move_state
	else:
		return idle_state
	
	return null
	
func process_frame(delta : float) -> State:
	return null

func mark_use_finished() -> void:
	_use_finished = true


func _on_animation_finished(anim_name : StringName) -> void:
	mark_use_finished()
