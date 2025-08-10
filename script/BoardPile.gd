class_name BoardPile
extends Node2D

const TAKE_BOARD_DESPERATION : float = 30
const BURN_BOARD_DESPERATION : float = -15

const BOARD_MAX_FRAME : int = 5

const BOARD_FUEL_VALUE : float = 50
const INITIAL_BOARDS_LEFT : int = 5

@export var board_pickupable_item : PickupableItemData

@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var interactable_component: InteractableComponent = %interactable_component
@onready var tool_tip_activation_component: ToolTipActivationComponent = %tool_tip_activation_component
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

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
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	
	if interacter.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = interacter.get_meta(pickup_meta_name)
		var item : PickupableItemData = board_pickupable_item.duplicate(true)
		item.use = board_use_function
		pickup_item_component.pickup_item(item)
		
		audio_stream_player_2d.play()
		
		if interacter.has_meta(stat_meta_name):
			var stat_data_component : StatDataComponent = interacter.get_meta(stat_meta_name)
			stat_data_component.change_desperation(TAKE_BOARD_DESPERATION)
		
		boards_left = boards_left - 1
		
func _check_for_empty() -> void:
	if boards_left <= 0:
		visible = false
		collision_shape_2d.disabled = true
		interactable_component.set_enabled(false)
		
	else:
		visible = true
		collision_shape_2d.disabled = true
		interactable_component.set_enabled(true)

func board_use_function(user : Node2D) -> void:
	var interacter_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.INTERACTER)
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)

	if not user.has_meta(interacter_meta_name) or not user.has_meta(pickup_meta_name):
		return	
	
	var interacter_component : InteracterComponent = user.get_meta(interacter_meta_name)
	
	for interactable_component in interacter_component.get_interactables():
		if not interactable_component.owner is Fireplace:
			continue
		
		var fireplace : Fireplace = interactable_component.owner as Fireplace
		fireplace.fuel_fire(BOARD_FUEL_VALUE)
		
		if user is Player:
			GlobalFlags.has_burn_board = true
		
		if user.has_meta(stat_meta_name):
			var stat_data_component : StatDataComponent = user.get_meta(stat_meta_name)
			stat_data_component.change_desperation(BURN_BOARD_DESPERATION)
		
		var pickup_item_component : PickupItemComponent = user.get_meta(pickup_meta_name)
		pickup_item_component.remove_item()
				
		return

func _update_sprite_animation(current_value : int, max_value : int, max_frame : int) -> void:
	sprite_2d.frame =  min(max_frame - 1, max_frame - float(current_value) / max_value * max_frame)
