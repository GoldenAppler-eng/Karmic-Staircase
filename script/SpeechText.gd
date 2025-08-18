class_name SpeechText
extends Control

const SPEECH_TWEEN_DURATION : float = 0.3
const SPEECH_TEXT_WAIT_TIME : float = 2

@onready var speech_end_timer: Timer = %SpeechEndTimer
@onready var dialogue_sfx: AudioStreamPlayer2D = $dialogue_sfx
@onready var label: Label = %Label
@onready var panel : Panel = %Panel

var text_queue : Array[String] = []

var current_tween : Tween

var _text_time_finished : bool = true

func _ready() -> void:
	label.text = ""
	panel.visible = false
	
	speech_end_timer.wait_time = SPEECH_TEXT_WAIT_TIME

func _physics_process(delta: float) -> void:
	panel.custom_minimum_size.x = label.size.x + 4
	
	if text_queue.is_empty():
		hide_speech_box()
		return
	
	speech_end_timer.wait_time = SPEECH_TEXT_WAIT_TIME / 3 if text_queue.size() > 1 else SPEECH_TEXT_WAIT_TIME
	
	#if _text_time_finished:
		#show_text(text_queue.front())

func set_text(text : String) -> void:
	label.text = text

func say(text : String) -> void:
	text_queue.append(text)
	
	show_text(text)

func show_text(text : String) -> void:
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
	_text_time_finished = false

func _on_speech_end_timer_timeout() -> void:
	_text_time_finished = true
	
	text_queue.pop_front()

func hide_speech_box() -> void:
	set_text("")
	label.visible_ratio = 0
	panel.visible = false
