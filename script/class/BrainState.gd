class_name BrainState
extends Node

var brain : AIBrain

var stat_data_component : StatDataComponent
var player_vision_component : PlayerVisionComponent
var pickup_item_component : PickupItemComponent
var interacter_component : InteracterComponent

var level : Level

func init(p_brain : AIBrain, p_stat_data_component : StatDataComponent, p_pickup_item_component : PickupItemComponent, p_interacter_component : InteracterComponent, p_player_vision_component : PlayerVisionComponent, p_level : Level) -> void:
	brain = p_brain
	stat_data_component = p_stat_data_component
	pickup_item_component = p_pickup_item_component
	player_vision_component = p_player_vision_component
	interacter_component = p_interacter_component
	
	level = p_level

	extra_init()

func extra_init() -> void:
	pass

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func process_physics(delta : float) -> BrainState:
	return null
	
