class_name ToolTipActivationComponent
extends Area2D

const TOOLTIP_ACTIVATION_DURATION : float = 0.5
const SCARY_THEME : Theme = preload("res://scary_theme.tres")

@export_multiline var tooltip : String

@export var tip: Label

var current_tween : Tween

@onready var show_up_sfx: AudioStreamPlayer2D = $show_up_sfx
@onready var panel : Panel = $Panel

func _ready() -> void:
	tip.text = tooltip
	tip.visible_ratio = 0
	
	tip.theme = SCARY_THEME
	hide_panel()

func activate() -> void:
	current_tween = create_tween()
	current_tween.tween_property(tip, "visible_ratio", 1, TOOLTIP_ACTIVATION_DURATION)
	show_up_sfx.play()
	panel.visible = true
	
	current_tween.tween_callback(show_up_sfx.stop)

func deactivate() -> void:
	current_tween.kill()
	show_up_sfx.stop()
	
	current_tween = create_tween()
	current_tween.tween_property(tip, "visible_ratio", 0, TOOLTIP_ACTIVATION_DURATION)
	
	current_tween.tween_callback(hide_panel)
	
func set_tooltip(new_tooltip : String) -> void:
	tooltip = new_tooltip
	tip.text = tooltip

func hide_panel() -> void:
	panel.visible = false
