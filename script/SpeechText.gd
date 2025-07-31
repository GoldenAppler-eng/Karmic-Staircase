class_name SpeechText
extends Control

@onready var label: Label = $Label

func set_text(text : String) -> void:
	label.text = text
