extends CharacterBody2D

@onready var input_brain: Node = %input_brain
@onready var movement_component: MovementComponent = %movement_component
@onready var state_machine: StateMachine = %state_machine
@onready var interacter_component: InteracterComponent = %interacter_component

func _ready() -> void:
	movement_component.init(self)
	interacter_component.init(self)
	state_machine.init(input_brain, movement_component, interacter_component)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
