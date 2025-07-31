class_name RotationTrackerComponent
extends Node

const STEP_PER_RADIAN : float = 1

var origin : Vector2 
var actor : Node2D

var prev_global_position : Vector2

var psuedo_vertical_coordinate : float = 0

func init(p_actor : Node2D, origin_node : Node2D) -> void:
	actor = p_actor
	origin = origin_node.global_position

func update_psuedo_vertical_coordinate() -> void:
	if not prev_global_position:
		prev_global_position = actor.global_position
		return
		
	var origin_to_prev : Vector2 = prev_global_position - origin
	var origin_to_current : Vector2 = actor.global_position - origin
	
	var delta_radians : float = origin_to_prev.angle_to(origin_to_current)
	
	psuedo_vertical_coordinate += delta_radians * STEP_PER_RADIAN
	
	prev_global_position = actor.global_position
	
