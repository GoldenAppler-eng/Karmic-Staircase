class_name Brain
extends Node

func wants_movement() -> bool:
	return false

func wants_sprint() -> bool:
	return false

func wants_attack() -> bool:
	return false

func wants_interact() -> bool:
	return false
	
func wants_use() -> bool:
	return false
	
func wants_pickup() -> bool:
	return false
	
func wants_drop() -> bool:
	return false

func get_movement_vector() -> Vector2:
	return Vector2(0, 0)
	
func shut_off() -> void:
	pass
