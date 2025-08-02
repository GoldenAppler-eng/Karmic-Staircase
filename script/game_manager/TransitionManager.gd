class_name TransitionManager
extends Node

@export var transition_canvas_layer : CanvasLayer
@export var transition_animation_player : AnimationPlayer

func fade_in() -> void:
	transition_canvas_layer.visible = true
	transition_animation_player.play("fade_in")
	
	await transition_animation_player.animation_finished

func fade_out() -> void:
	transition_animation_player.play("fade_out")
	
	await transition_animation_player.animation_finished

	transition_canvas_layer.visible = false
