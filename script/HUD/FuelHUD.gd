extends HBoxContainer

@export var fireplace : Fireplace
@export var tooltip_activation_component : ToolTipActivationComponent

@onready var fuel_progress: TextureProgressBar = %fuel_progress

func _ready() -> void:
	tooltip_activation_component.tooltip_activated.connect(_on_tooltip_activated)
	tooltip_activation_component.tooltip_deactivated.connect(_on_tooltip_deactivated)

func _physics_process(delta: float) -> void:
	fuel_progress.value = fireplace.fuel / fireplace.MAX_FUEL * 100

func _on_tooltip_activated() -> void:
	visible = true
	
func _on_tooltip_deactivated() -> void:
	visible = false
