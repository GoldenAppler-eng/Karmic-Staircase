class_name HurtboxComponent
extends Area2D

var _hurt : bool = false

func init() -> void:
	owner.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.HURTBOX), self)

func get_hurt() -> void:
	_hurt = true

func is_hurt() -> bool:	
	return _hurt

func revive() -> void:
	_hurt = false
