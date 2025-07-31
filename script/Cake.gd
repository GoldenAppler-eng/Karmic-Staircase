extends RigidBody2D

const INITIAL_NUMBER_OF_PIECES = 1

var cake_hunger_regen_amount : float = 30

@export var cake_pickupable_item : PickupableItemData

@onready var interactable_component: InteractableComponent = %interactable_component

var num_of_pieces = INITIAL_NUMBER_OF_PIECES

func _ready() -> void:
	interactable_component.interact = interact
	cake_pickupable_item.use = cake_use_function
	
func interact(interacter : Node2D) -> void:	
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)
	
	if interacter.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = interacter.get_meta(pickup_meta_name)
		pickup_item_component.pickup_item(cake_pickupable_item)
		
		num_of_pieces -= 1
		_check_for_empty()

func _check_for_empty() -> void:
	if num_of_pieces <= 0:
		visible = false
		interactable_component.set_enabled(false)

func cake_use_function(user : Node2D) -> void:
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)

	if user.has_meta(stat_meta_name):
		var stat_data_component : StatDataComponent = user.get_meta(stat_meta_name)
		
		stat_data_component.change_hunger(cake_hunger_regen_amount)
		
	if user.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = user.get_meta(pickup_meta_name)
		pickup_item_component.remove_item()
