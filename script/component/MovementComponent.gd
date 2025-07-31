class_name MovementComponent
extends Node

const SPEED_MULTIPLIER : float = 1000
const SPEED_PER_HUNGER_MULTIPLIER : float = 0.1
const HUNGER_SPEED_MULTIPLIER_OFFSET : float = 0.2

const HUNGER_THRESHOLD : float = 50

@export var speed : float = 0
@export var sprint_multiplier : float = 1.5

var actor : CharacterBody2D
var _is_sprinting : bool = false

var stat_data_component : StatDataComponent

func init(p_actor : CharacterBody2D, p_stat_data_component : StatDataComponent) -> void:
	actor = p_actor
	speed *= SPEED_MULTIPLIER

	stat_data_component = p_stat_data_component

func move(delta : float, movement_vector : Vector2) -> void:
	var normalized_movement_vector : Vector2 = movement_vector.normalized()
	var actual_speed : float =  speed * delta
	
	if _is_sprinting: actual_speed *= sprint_multiplier
	if stat_data_component.data.hunger < HUNGER_THRESHOLD: 
		actual_speed *= 1 - SPEED_PER_HUNGER_MULTIPLIER * 10 * (1 - stat_data_component.data.hunger/stat_data_component.data.MAX_HUNGER) + HUNGER_SPEED_MULTIPLIER_OFFSET
	
	actor.velocity = normalized_movement_vector * actual_speed
	
	actor.move_and_slide()
	
func stop_movement() -> void:
	actor.velocity = Vector2(0, 0)
	actor.move_and_slide()

func set_sprinting(sprint : bool) -> void:
	_is_sprinting = sprint
