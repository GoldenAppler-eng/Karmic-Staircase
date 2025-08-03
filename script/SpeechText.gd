class_name SpeechText
extends Control

const SPEECH_TWEEN_DURATION : float = 0.2

@onready var label: Label = $Label
@onready var speech_end_timer: Timer = $SpeechEndTimer

var current_tween : Tween

func _ready() -> void:
	label.text = ""

func set_text(text : String) -> void:
	label.text = text

func say(text : String) -> void:
	if current_tween:
		current_tween.kill()
	
	set_text(text)
	label.visible_ratio = 0
	
	current_tween = create_tween()
	current_tween.tween_property(label, "visible_ratio", 1, SPEECH_TWEEN_DURATION)
	
	speech_end_timer.start()

func _on_speech_end_timer_timeout() -> void:
	set_text("")
	label.visible_ratio = 0
