class_name MovementComponent
extends Node

const FOOTSTEP_SFX_DICTIONARY : Dictionary = {
	0 : preload("res://audio/footstep_1.wav"),
	1 : preload("res://audio/footstep_2.wav"),
	2 : preload("res://audio/footstep_3.wav"),
	3 : preload("res://audio/footstep_4.wav"),
	4 : preload("res://audio/footstep_5.wav")
}

const SPEED_MULTIPLIER : float = 1000
const SPEED_PER_HUNGER_MULTIPLIER : float = 0.1
const HUNGER_SPEED_MULTIPLIER_OFFSET : float = 0.2

const HUNGER_THRESHOLD : float = 50

@export var speed : float = 0
@export var sprint_multiplier : float = 1.5

@export var footstep_ready_timer : Timer
@export var footstep_sfx_player : AudioStreamPlayer2D

var actor : CharacterBody2D
var _is_sprinting : bool = false
var _is_moving : bool = false

var last_facing_right : bool = true

var stat_data_component : StatDataComponent

var _footstep_ready : bool = false

func init(p_actor : CharacterBody2D, p_stat_data_component : StatDataComponent) -> void:
	actor = p_actor
	speed *= SPEED_MULTIPLIER

	stat_data_component = p_stat_data_component

	footstep_ready_timer.timeout.connect(_on_footstep_ready_timer_timeout)

func move(delta : float, movement_vector : Vector2) -> void:
	var normalized_movement_vector : Vector2 = movement_vector.normalized()
	var actual_speed : float =  speed * delta
	
	if _is_sprinting: actual_speed *= sprint_multiplier
	
	if stat_data_component.data.hunger < HUNGER_THRESHOLD: 
		actual_speed *= 1 - SPEED_PER_HUNGER_MULTIPLIER * 10 * (1 - stat_data_component.data.hunger/stat_data_component.data.MAX_HUNGER) + HUNGER_SPEED_MULTIPLIER_OFFSET
	
	actor.velocity = normalized_movement_vector * actual_speed
	
	_is_moving = true
	
	if movement_vector.x > 0:
		last_facing_right = true
	elif movement_vector.x < 0:
		last_facing_right = false
	
	actor.move_and_slide()
	play_footstep_sfx()
	
func stop_movement() -> void:
	actor.velocity = Vector2(0, 0)
	actor.move_and_slide()
	
	_is_moving = false

func set_sprinting(sprint : bool) -> void:
	_is_sprinting = sprint
	footstep_ready_timer.wait_time = 0.2 if sprint else 0.5

func is_moving() -> bool:
	return _is_moving

func play_footstep_sfx() -> void:
	if not _footstep_ready:
		return
	
	_footstep_ready = false
	
	footstep_sfx_player.stream = FOOTSTEP_SFX_DICTIONARY[randi_range(0, 4)]
	footstep_sfx_player.play()

func _on_footstep_ready_timer_timeout() -> void:
	_footstep_ready = true
