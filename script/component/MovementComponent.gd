class_name MovementComponent
extends Node

const SPEED_MULTIPLIER : float = 1000

@export var speed : float = 0
@export var sprint_multiplier : float = 1.5

var actor : CharacterBody2D
var _is_sprinting : bool = false

func init(p_actor : CharacterBody2D) -> void:
	actor = p_actor
	speed *= SPEED_MULTIPLIER

func move(delta : float, movement_vector : Vector2) -> void:
	var normalized_movement_vector : Vector2 = movement_vector.normalized()
	var actual_speed : float =  speed * delta
	
	if _is_sprinting: actual_speed *= sprint_multiplier
	
	actor.velocity = normalized_movement_vector * actual_speed
	
	actor.move_and_slide()
	
func stop_movement() -> void:
	actor.velocity = Vector2(0, 0)
	actor.move_and_slide()

func set_sprinting(sprint : bool) -> void:
	_is_sprinting = sprint
