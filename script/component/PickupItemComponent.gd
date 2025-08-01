class_name PickupItemComponent
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var current_item : PickupableItemData
var item_user : Node2D

func init(p_item_user : Node2D) -> void:
	item_user = p_item_user
	
	item_user.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM), self)

func use_item() -> void:
	current_item.use.call(item_user)

func remove_item() -> void:
	current_item = null
	
	sprite_2d.texture = null

func pickup_item(item : PickupableItemData) -> void:
	current_item = item
	
	sprite_2d.texture = current_item.hold_sprite
	sprite_2d.offset = current_item.hold_offset
	sprite_2d.scale = current_item.scale

func drop_item() -> void:
	remove_item()

func is_not_holding_item() -> bool:
	return not current_item
	
func can_be_used_for_attack() -> bool:
	return current_item.can_use_to_attack

func get_current_item_name() -> StringName:
	if current_item:
		return current_item.name
		
	return ""
