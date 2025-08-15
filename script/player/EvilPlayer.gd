class_name EvilPlayer
extends CharacterBody2D

@export var starting_weapon : PickupableItemData

@export var origin_node : Node2D

@onready var state_machine: StateMachine = %state_machine

@onready var ai_brain : AIBrain = %ai_brain
@onready var brain_state_machine : BrainStateMachine = %brain_state_machine

@onready var movement_component: MovementComponent = %movement_component
@onready var interacter_component: InteracterComponent = %interacter_component
@onready var rotation_tracker_component: RotationTrackerComponent = %rotation_tracker_component
@onready var pickup_item_component: PickupItemComponent = %pickup_item_component
@onready var stat_data_component: StatDataComponent = %stat_data_component
@onready var hurtbox_component: HurtboxComponent = %hurtbox_component

@onready var animation_controller : AnimationController = %animation_controller

@onready var player_vision_component: PlayerVisionComponent = %player_vision_component

@onready var player_statistics_hud: PlayerStatisticsHUD = %PlayerStatisticsHUD

@export var level : Level

var initial_position : Vector2

var using_ai : bool = true

func _ready() -> void:
	stat_data_component.init()	
	stat_data_component.data.change_desperation(100)
	
	animation_controller.init()

	movement_component.init(self, stat_data_component)
	interacter_component.init(self)
	rotation_tracker_component.init(self, origin_node)
	pickup_item_component.init(self)
	
	player_vision_component.init(self, movement_component, rotation_tracker_component)
	
	brain_state_machine.init(ai_brain, stat_data_component, pickup_item_component, interacter_component, player_vision_component, level)
	brain_state_machine.activate()
	state_machine.init(ai_brain, animation_controller, movement_component, interacter_component, pickup_item_component, stat_data_component, hurtbox_component)
	
	player_statistics_hud.init(stat_data_component)
	
	pickup_item_component.pickup_item(starting_weapon)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
		
func _physics_process(delta: float) -> void:
	if using_ai:
		brain_state_machine.process_physics(delta)
	
	state_machine.process_physics(delta)
	animation_controller.process_physics(delta)

	rotation_tracker_component.update_psuedo_vertical_coordinate()
	
func set_vertical_coordinate(vertical_coordinate : float) -> void:
	rotation_tracker_component.psuedo_vertical_coordinate = vertical_coordinate
	
func set_level(p_level : Level) -> void:
	level = p_level
