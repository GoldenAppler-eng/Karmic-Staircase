class_name RecordedPlayer
extends CharacterBody2D

@export var origin_node : Node2D

@onready var recorded_brain: RecordedBrain = %recorded_brain
@onready var state_machine: StateMachine = %state_machine

@onready var movement_component: MovementComponent = %movement_component
@onready var interacter_component: InteracterComponent = %interacter_component
@onready var rotation_tracker_component: RotationTrackerComponent = %rotation_tracker_component
@onready var pickup_item_component: PickupItemComponent = %pickup_item_component
@onready var stat_data_component: StatDataComponent = %stat_data_component
@onready var hurtbox_component: HurtboxComponent = %hurtbox_component
@onready var animation_controller : AnimationController = %animation_controller

@onready var step_recorder_component: StepRecorderComponent = %step_recorder_component

@onready var speech_text: SpeechText = %speech_text

var initial_position : Vector2

func _ready() -> void:
	stat_data_component.init()	

	animation_controller.init()

	movement_component.init(self, stat_data_component)
	interacter_component.init(self)
	rotation_tracker_component.init(self, origin_node)
	pickup_item_component.init(self)
	
	state_machine.init(recorded_brain, animation_controller, movement_component, interacter_component, pickup_item_component, stat_data_component, hurtbox_component)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
	speech_text.set_text(str(rotation_tracker_component.psuedo_vertical_coordinate))
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	animation_controller.process_physics(delta)

	rotation_tracker_component.update_psuedo_vertical_coordinate()
	

func set_vertical_coordinate(vertical_coordinate : float) -> void:
	rotation_tracker_component.psuedo_vertical_coordinate = vertical_coordinate
	
func set_recorded_brain_data(step_data : Array[BrainFrameData], item_data : Array[PickupFrameData]) -> void:
	recorded_brain.recorded_brain_data = step_data
	recorded_brain.recorded_item_data = item_data

func reset_player() -> void:
	global_position = initial_position
	recorded_brain.current_frame = 0
	
	state_machine.reset_state_machine()

func get_recorded_steps() -> Array[BrainFrameData]:
	return step_recorder_component.get_recorded_data()
	
func clear_recorded_steps() -> void:
	step_recorder_component.clear()
