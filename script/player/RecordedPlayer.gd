class_name RecordedPlayer
extends CharacterBody2D

const DESPERATION_THRESHOLD : float = 50

@export var origin_node : Node2D

@onready var recorded_brain: RecordedBrain = %recorded_brain
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

@onready var interruption_detection_component: InterruptionDetectionComponent = %interruption_detection_component

@onready var player_statistics_hud: PlayerStatisticsHUD = %PlayerStatisticsHUD

var level : Level

var initial_position : Vector2
var initial_stats : StatData
var initial_vertical_coordinate : float

var using_ai : bool = false

func _ready() -> void:
	stat_data_component.init()	

	animation_controller.init()

	movement_component.init(self, stat_data_component)
	interacter_component.init(self)
	rotation_tracker_component.init(self, origin_node)
	pickup_item_component.init(self)
	
	player_vision_component.init(self, movement_component, rotation_tracker_component)
	
	brain_state_machine.init(ai_brain, stat_data_component, pickup_item_component, interacter_component, player_vision_component, level)
	state_machine.init(recorded_brain, animation_controller, movement_component, interacter_component, pickup_item_component, stat_data_component, hurtbox_component)

	player_statistics_hud.init(stat_data_component)

	interruption_detection_component.interrupted.connect(_on_recording_interrupted)
	
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
	initial_vertical_coordinate = vertical_coordinate
	
func set_level(p_level : Level) -> void:
	level = p_level

func set_recorded_brain_data(step_data : Array[BrainFrameData], item_data : Array[PickupFrameData]) -> void:
	recorded_brain.recorded_brain_data = step_data
	recorded_brain.recorded_item_data = item_data

func reset_player() -> void:
	global_position = initial_position
	rotation_tracker_component.psuedo_vertical_coordinate = initial_vertical_coordinate
	stat_data_component.data = initial_stats.duplicate()
	
	recorded_brain.reset_brain()
	use_recorded_brain()
	
	state_machine.reset_state_machine()

func _on_recording_interrupted() -> void:
	brain_state_machine.activate()
	
	if stat_data_component.data.desperation >= DESPERATION_THRESHOLD:
		state_machine.set_brain(ai_brain)
		using_ai = true
	else:
		recorded_brain.continue_brain()
		recorded_brain.add_seen_player()

func set_stats(stats : StatData) -> void:
	stat_data_component.data = stats
	initial_stats = stats.duplicate()

func use_recorded_brain() -> void:
	state_machine.set_brain(recorded_brain)
	using_ai = false
