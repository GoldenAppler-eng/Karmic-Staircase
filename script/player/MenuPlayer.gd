class_name MenuPlayer
extends CharacterBody2D

@export var origin_node : Node2D

@onready var menu_input_brain: Brain = %menu_input_brain
@onready var state_machine: StateMachine = %state_machine

@onready var movement_component: MovementComponent = %movement_component
@onready var interacter_component: InteracterComponent = %interacter_component

@onready var stat_data_component: StatDataComponent = %null_stat_data_component
@onready var pickup_item_component: PickupItemComponent = %null_pickup_item_component
@onready var hurtbox_component: HurtboxComponent = %null_hurtbox_component

@onready var animation_controller : AnimationController = %animation_controller

func _ready() -> void:
	stat_data_component.init()
	pickup_item_component.init(self)
	hurtbox_component.init()
	
	animation_controller.init()
	
	movement_component.init(self, stat_data_component)
	interacter_component.init(self)
	
	state_machine.init(menu_input_brain, animation_controller, movement_component, interacter_component, pickup_item_component, stat_data_component, hurtbox_component)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
		
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	animation_controller.process_physics(delta)
