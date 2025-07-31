extends RigidBody2D

@export var board_pickupable_item : PickupableItemData

@onready var interactable_component: InteractableComponent = %interactable_component

func _ready() -> void:
	interactable_component.interact = interact
	board_pickupable_item.use = board_use_function
	
func interact(interacter : Node2D) -> void:	
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)
	
	if interacter.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = interacter.get_meta(pickup_meta_name)
		pickup_item_component.pickup_item(board_pickupable_item)

func board_use_function(user : Node2D) -> void:
	pass
