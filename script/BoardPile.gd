class_name BoardPile
extends Node2D

const BOARD_MAX_FRAME : int = 5

const BOARD_FUEL_VALUE : float = 50
const INITIAL_BOARDS_LEFT : int = 5

@export var board_pickupable_item : PickupableItemData

@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var interactable_component: InteractableComponent = %interactable_component

var boards_left : int:
	set(value):
		boards_left = value
		_update_sprite_animation(boards_left, INITIAL_BOARDS_LEFT, BOARD_MAX_FRAME)
		_check_for_empty()

func _ready() -> void:
	interactable_component.interact = interact
	board_pickupable_item.use = board_use_function
	
	boards_left = INITIAL_BOARDS_LEFT
	
func interact(interacter : Node2D) -> void:	
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)
	
	if interacter.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = interacter.get_meta(pickup_meta_name)
		var item : PickupableItemData = board_pickupable_item.duplicate(true)
		item.use = board_use_function
		pickup_item_component.pickup_item(item)
		
		boards_left = boards_left - 1
		
func _check_for_empty() -> void:
	if boards_left <= 0:
		visible = false
		interactable_component.set_enabled(false)
	else:
		visible = true
		interactable_component.set_enabled(true)

func board_use_function(user : Node2D) -> void:
	var interacter_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.INTERACTER)
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)

	if not user.has_meta(interacter_meta_name) or not user.has_meta(pickup_meta_name):
		return	
	
	var interacter_component : InteracterComponent = user.get_meta(interacter_meta_name)
	
	for interactable_component in interacter_component.get_interactables():
		if not interactable_component.owner is Fireplace:
			continue
		
		var fireplace : Fireplace = interactable_component.owner as Fireplace
		fireplace.fuel_fire(BOARD_FUEL_VALUE)
		
		var pickup_item_component : PickupItemComponent = user.get_meta(pickup_meta_name)
		pickup_item_component.remove_item()
				
		return

func _update_sprite_animation(current_value : int, max_value : int, max_frame : int) -> void:
	sprite_2d.frame =  max_frame - float(current_value) / max_value * max_frame
