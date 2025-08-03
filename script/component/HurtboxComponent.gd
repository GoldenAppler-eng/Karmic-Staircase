class_name HurtboxComponent
extends Area2D

var _hurt : bool = false

func init() -> void:
	owner.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.HURTBOX), self)

func get_hurt() -> void:
	_hurt = true
	disable_hurtbox()

func is_hurt() -> bool:	
	return _hurt

func revive() -> void:
	_hurt = false
	enable_hurtbox()

func disable_hurtbox() -> void:
	monitorable = false

func enable_hurtbox() -> void:
	monitorable = true
