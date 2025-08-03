class_name State
extends Node

var brain : Brain

var animation_controller : AnimationController

var movement_component : MovementComponent
var interacter_component : InteracterComponent
var pickup_item_component : PickupItemComponent
var stat_data_component : StatDataComponent
var hurtbox_component : HurtboxComponent

func init(p_brain : Brain, p_animation_controller : AnimationController, p_movement_component : MovementComponent, p_interacter_component : InteracterComponent, p_pickup_item_component : PickupItemComponent, p_stat_data_component : StatDataComponent, p_hurtbox_component : HurtboxComponent) -> void:
	brain = p_brain
	
	animation_controller = p_animation_controller
	
	movement_component = p_movement_component
	interacter_component = p_interacter_component
	pickup_item_component = p_pickup_item_component
	stat_data_component = p_stat_data_component
	hurtbox_component = p_hurtbox_component
	
	extra_init()
	
func extra_init() -> void:
	pass
	
func enter() -> void:
	pass
	
func exit() -> void:
	pass	
	
func process_physics(delta : float) -> State:
	return null
	
func process_frame(delta : float) -> State:
	return null

func set_brain(p_brain : Brain) -> void:
	brain = p_brain
