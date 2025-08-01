class_name Player
extends CharacterBody2D

@export var origin_node : Node2D

@onready var input_brain: Brain = %input_brain
@onready var movement_component: MovementComponent = %movement_component
@onready var state_machine: StateMachine = %state_machine
@onready var interacter_component: InteracterComponent = %interacter_component
@onready var rotation_tracker_component: RotationTrackerComponent = %rotation_tracker_component
@onready var pickup_item_component: PickupItemComponent = %pickup_item_component
@onready var stat_data_component: StatDataComponent = %stat_data_component
@onready var hurtbox_component: HurtboxComponent = %hurtbox_component

@onready var speech_text: SpeechText = %speech_text

func _ready() -> void:
	stat_data_component.init()
	
	movement_component.init(self, stat_data_component)
	interacter_component.init(self)
	rotation_tracker_component.init(self, origin_node)
	pickup_item_component.init(self)
	hurtbox_component.init()
	
	state_machine.init(input_brain, movement_component, interacter_component, pickup_item_component, stat_data_component, hurtbox_component)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
	speech_text.set_text(str(rotation_tracker_component.psuedo_vertical_coordinate))
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

	rotation_tracker_component.update_psuedo_vertical_coordinate()
