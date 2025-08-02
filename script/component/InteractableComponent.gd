class_name InteractableComponent
extends Area2D

@export var interact_priority : int = 0

var interact : Callable = func(interacter : Node2D): pass
var _enabled : bool = true

func set_enabled(enabled : bool) -> void:
	_enabled = enabled
