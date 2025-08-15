extends HurtboxComponent

func init() -> void:
	owner.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.HURTBOX), self)

func get_hurt() -> void:
	pass

func is_hurt() -> bool:	
	return false

func revive() -> void:
	pass

func disable_hurtbox() -> void:
	pass
	
func enable_hurtbox() -> void:
	pass
