extends PickupItemComponent

func init(p_item_user : Node2D) -> void:
	item_user = p_item_user
	
	item_user.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM), self)

func use_item() -> void:
	pass

func remove_item() -> void:
	pass

func pickup_item(item : PickupableItemData) -> void:
	pass

func drop_item() -> void:
	pass

func consume_item() -> void:
	pass

func is_not_holding_item() -> bool:
	return true
	
func can_be_used_for_attack() -> bool:
	return false

func get_current_item_name() -> StringName:
	return ""
