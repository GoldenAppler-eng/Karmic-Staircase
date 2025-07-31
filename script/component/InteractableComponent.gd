class_name InteractableComponent
extends Area2D

var interact : Callable
var _enabled : bool

func set_enabled(enabled : bool) -> void:
	_enabled = enabled
	monitorable = _enabled
