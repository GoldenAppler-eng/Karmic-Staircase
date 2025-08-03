class_name Cake
extends Node2D

const TAKE_CAKE_DESPERATION : float = 5
const EAT_CAKE_DESPERATION : float = 15

const CAKE_MAX_FRAME : int = 3
const INITIAL_CAKE_LEFT : int = 4

const CAKE_HUNGER_REFILL : float = 30

@export var cake_pickupable_item : PickupableItemData

@onready var interactable_component: InteractableComponent = %interactable_component

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var eat_sfx: AudioStreamPlayer = $eat_sfx

var cake_left : int:
	set(value):
		cake_left = value
		_update_sprite_animation(cake_left, INITIAL_CAKE_LEFT, CAKE_MAX_FRAME)
		_check_for_empty()

func _ready() -> void:
	interactable_component.interact = interact
	
	cake_left = INITIAL_CAKE_LEFT
	
func interact(interacter : Node2D) -> void:	
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	
	if interacter.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = interacter.get_meta(pickup_meta_name)
		var item : PickupableItemData = cake_pickupable_item.duplicate(true)
		item.use = cake_use_function
		pickup_item_component.pickup_item(item)		
		
		audio_stream_player_2d.play()
		
		if interacter.has_meta(stat_meta_name):
			var stat_data_component : StatDataComponent = interacter.get_meta(stat_meta_name)
			stat_data_component.change_desperation(TAKE_CAKE_DESPERATION)
		
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
		
		stat_data_component.change_hunger(CAKE_HUNGER_REFILL)
		stat_data_component.change_desperation(EAT_CAKE_DESPERATION)
		
	if user.has_meta(pickup_meta_name):
		var pickup_item_component : PickupItemComponent = user.get_meta(pickup_meta_name)
		pickup_item_component.consume_item()
		
		eat_sfx.play()

func _update_sprite_animation(current_value : int, max_value : int, max_frame : int) -> void:
	sprite_2d.frame =  min(max_frame , max_frame - float(current_value) / max_value * max_frame)
	
