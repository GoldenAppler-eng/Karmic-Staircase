class_name AIBrain
extends Brain

@export var nav_agent : NavigationAgent2D
@export var path_refresh_timer : Timer

var target_position : Vector2 = Vector2(0, 0)
var target_player : CharacterBody2D

var _wants_movement : bool = false
var _wants_attack : bool = false
var _wants_sprint : bool = false
var _wants_interact : bool = false

func _ready() -> void:
	path_refresh_timer.timeout.connect(_on_path_refresh_timeout)

func find_target_player() -> void:
	if not target_player:
		return
		
	set_target_position(target_player.global_position)

func set_target_position(position : Vector2) -> void:
	target_position = position

func wants_movement() -> bool:
	return _wants_movement

func wants_sprint() -> bool:
	return _wants_sprint

func wants_attack() -> bool:
	return _wants_attack

func wants_interact() -> bool:
	return _wants_interact
	
func wants_use() -> bool:
	return false
	
func wants_pickup() -> bool:
	return false

func wants_drop() -> bool:
	return false

func get_movement_vector() -> Vector2:
	if not _wants_movement:
		return Vector2(0, 0)
	
	return (nav_agent.get_next_path_position() - (owner as Node2D).global_position).normalized()

func _on_path_refresh_timeout() -> void:
	nav_agent.target_position = target_position
