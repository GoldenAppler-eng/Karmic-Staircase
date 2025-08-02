class_name ScreenShaderManager
extends Node

@export var screen_shader : CanvasLayer

func hide() -> void:
	screen_shader.visible = false
	
func show() -> void:
	screen_shader.visible = true
