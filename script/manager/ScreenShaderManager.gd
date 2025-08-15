class_name ScreenShaderManager
extends Node

@export var screen_shader : CanvasLayer

@onready var darkness: ColorRect = $"../ScreenShader/Control/darkness"
@onready var vignette: ColorRect = $"../ScreenShader/Control/vignette"

func hide() -> void:
	screen_shader.visible = false

func show_darkness_only() -> void:
	screen_shader.visible = true
	
	darkness.visible = true
	vignette.visible = false
	
func show_vignette_only() -> void:
	screen_shader.visible = true
	
	darkness.visible = false
	vignette.visible = true

func show() -> void:
	screen_shader.visible = true
	
	darkness.visible = true
	vignette.visible = true
