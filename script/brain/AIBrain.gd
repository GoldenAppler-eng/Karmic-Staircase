class_name AIBrain
extends Brain

const CLOSE_DISTANCE : float = 5

@export var nav_agent : NavigationAgent2D
@export var path_refresh_timer : Timer

var target_position : Vector2 = Vector2(0, 0)
var target_player : CharacterBody2D

var _wants_movement : bool = false
var _wants_attack : bool = false
var _wants_sprint : bool = false
var _wants_interact : bool = false
var _wants_use : bool = false

func _ready() -> void:
	path_refresh_timer.timeout.connect(_on_path_refresh_timeout)

func find_target_player() -> void:
	if not target_player:
		return
	
	set_target_position(target_player.global_position)
	nav_agent.path_desired_distance = 40

func set_target_position(position : Vector2) -> void:
	target_position = position
	nav_agent.path_desired_distance = 20

func wants_movement() -> bool:
	return _wants_movement

func wants_sprint() -> bool:
	return _wants_sprint

func wants_attack() -> bool:
	return _wants_attack

func wants_interact() -> bool:
	return _wants_interact
	
func wants_use() -> bool:
	return _wants_use
	
func wants_pickup() -> bool:
	return false

func wants_drop() -> bool:
	return false

func get_movement_vector() -> Vector2:
	if not _wants_movement:
		return Vector2(0, 0)
	
	var direction : Vector2 = nav_agent.get_next_path_position() - (owner as Node2D).global_position
	
	return direction.normalized()

func is_close_to_target() -> bool:
	if target_position.distance_to((owner as Node2D).global_position) < CLOSE_DISTANCE:
		return true
	
	return false

func _on_path_refresh_timeout() -> void:
	nav_agent.target_position = target_position
