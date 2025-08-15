extends StatDataComponent

func init() -> void:
	hunger_degeneration_timer = null
	
	owner.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA), self)
	
	data = StatData.new()
	data.resource_local_to_scene = true
	
func is_starving() -> bool:
	return false
	
func change_hunger(net_change : float) -> void:
	pass

func change_desperation(net_change : float) -> void:
	pass

func set_hunger_degeneration_amount(amount : float = DEFAULT_HUNGER_DEGENERATION_AMOUNT) -> void:
	pass

func _on_hunger_degeneration_timer_timeout() -> void:
	pass
