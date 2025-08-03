class_name Player
extends CharacterBody2D

@export var origin_node : Node2D

@onready var input_brain: Brain = %input_brain
@onready var state_machine: StateMachine = %state_machine

@onready var movement_component: MovementComponent = %movement_component
@onready var interacter_component: InteracterComponent = %interacter_component
@onready var rotation_tracker_component: RotationTrackerComponent = %rotation_tracker_component
@onready var pickup_item_component: PickupItemComponent = %pickup_item_component
@onready var stat_data_component: StatDataComponent = %stat_data_component
@onready var hurtbox_component: HurtboxComponent = %hurtbox_component

@onready var step_recorder_component: StepRecorderComponent = %step_recorder_component
@onready var animation_controller : AnimationController = %animation_controller

@onready var player_vision_component: PlayerVisionComponent = %player_vision_component

@onready var speech_text: SpeechText = %speech_text

func _ready() -> void:
	stat_data_component.init()
	
	animation_controller.init()
	
	movement_component.init(self, stat_data_component)
	interacter_component.init(self)
	rotation_tracker_component.init(self, origin_node)
	pickup_item_component.init(self)
	hurtbox_component.init()
	
	player_vision_component.init(self, movement_component, rotation_tracker_component)
	
	state_machine.init(input_brain, animation_controller, movement_component, interacter_component, pickup_item_component, stat_data_component, hurtbox_component)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
	speech_text.set_text(str(rotation_tracker_component.psuedo_vertical_coordinate))
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	animation_controller.process_physics(delta)

	rotation_tracker_component.update_psuedo_vertical_coordinate()

func get_vertical_coordinate() -> float:
	return rotation_tracker_component.psuedo_vertical_coordinate

func get_recorded_steps() -> Array[BrainFrameData]:
	return step_recorder_component.get_recorded_data()

func get_recorded_items() -> Array[PickupFrameData]:
	return step_recorder_component.get_recorded_items()

func clear_recorded_steps() -> void:
	step_recorder_component.clear()
