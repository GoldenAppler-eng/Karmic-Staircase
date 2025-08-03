class_name SpeechText
extends Control

const SPEECH_TWEEN_DURATION : float = 0.3

@onready var speech_end_timer: Timer = $SpeechEndTimer
@onready var dialogue_sfx: AudioStreamPlayer2D = $dialogue_sfx
@onready var label: Label = %Label
@onready var panel : Panel = %Panel

var current_tween : Tween

func _ready() -> void:
	label.text = ""
	panel.visible = false

func set_text(text : String) -> void:
	label.text = text

func say(text : String) -> void:
	if current_tween:
		current_tween.kill()
	
	set_text(text)
	label.visible_ratio = 0
	panel.visible = true
	
	current_tween = create_tween()
	current_tween.tween_property(label, "visible_ratio", 1, SPEECH_TWEEN_DURATION)
	dialogue_sfx.play()
	
	current_tween.tween_callback(dialogue_sfx.stop)
	
	speech_end_timer.start()

func _on_speech_end_timer_timeout() -> void:
	set_text("")
	label.visible_ratio = 0
	panel.visible = false
