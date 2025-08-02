class_name Cake
extends Node2D

const INITIAL_CAKE_LEFT = 1

var cake_hunger_regen_amount : float = 30

@export var cake_pickupable_item : PickupableItemData

@onready var interactable_component: InteractableComponent = %interactable_component

var cake_left : int:
	set(value):
		cake_left = value
		_check_for_empty()

func _ready() -> void:
	interactable_component.interact = interact
	
	cake_left = INITIAL_CAKE_LEFT
	
func interact(interacter : Node2D) -> void:	
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)
	
	if interacter.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = interacter.get_meta(pickup_meta_name)
		var item : PickupableItemData = cake_pickupable_item.duplicate(true)
		item.use = cake_use_function
		pickup_item_component.pickup_item(item)		
		
		cake_left = cake_left - 1

func _check_for_empty() -> void:
	if cake_left <= 0:
		visible = false
		interactable_component.set_enabled(false)
	else:
		visible = true
		interactable_component.set_enabled(true)

func cake_use_function(user : Node2D) -> void:
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)

	if user.has_meta(stat_meta_name):
		var stat_data_component : StatDataComponent = user.get_meta(stat_meta_name)
		
		stat_data_component.change_hunger(cake_hunger_regen_amount)
		
	if user.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = user.get_meta(pickup_meta_name)
		pickup_item_component.remove_item()
