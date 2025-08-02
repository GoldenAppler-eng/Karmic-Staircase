extends State

const ATTACK_HIT_DESPERATION : float = 50

@export var idle_state : State
@export var move_state : State
@export var dead_state : State

@export var damager_component : DamagerComponent

var _attack_finished : bool = false
var dealt_damage : bool = false

func extra_init() -> void:
	animation_controller.animation_finished.connect(_on_animation_finished)
	
func enter() -> void:
	_attack_finished = false
	dealt_damage = damager_component.deal_damage()
	
	animation_controller.play_animation("attack")
	
func exit() -> void:
	if dealt_damage:
		pickup_item_component.consume_item()	
		stat_data_component.change_desperation(ATTACK_HIT_DESPERATION)
	
func process_physics(delta : float) -> State:
	if not _attack_finished:
		return null
	
	if hurtbox_component.is_hurt():
		return dead_state
	
	if brain.wants_movement():
		return move_state
	else:
		return idle_state
	
	return null
	
func process_frame(delta : float) -> State:
	return null

func mark_attack_finished() -> void:
	_attack_finished = true

func _on_animation_finished(anim_name : StringName) -> void:
	mark_attack_finished()
