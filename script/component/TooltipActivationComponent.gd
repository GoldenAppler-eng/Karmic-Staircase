class_name ToolTipActivationComponent
extends Area2D

const TOOLTIP_ACTIVATION_DURATION : float = 0.5

@export_multiline var tooltip : String

@export var tip: Label

var current_tween : Tween

func _ready() -> void:
	tip.text = tooltip
	tip.visible_ratio = 0

func activate() -> void:
	current_tween = create_tween()
	current_tween.tween_property(tip, "visible_ratio", 1, TOOLTIP_ACTIVATION_DURATION)
		
func deactivate() -> void:
	current_tween.kill()
	
	current_tween = create_tween()
	current_tween.tween_property(tip, "visible_ratio", 0, TOOLTIP_ACTIVATION_DURATION)
		
func set_tooltip(new_tooltip : String) -> void:
	tooltip = new_tooltip
	tip.text = tooltip
