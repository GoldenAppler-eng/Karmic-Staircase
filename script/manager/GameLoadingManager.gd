class_name GameLoadingManager
extends Node

const LOADING_TIME : float = 1

const game_prefab : PackedScene = preload("res://scene/game.tscn")

@export var core : Node
@export var transition_manager : TransitionManager
@export var screen_shader_manager : ScreenShaderManager

var current_game : Node

func load_game() -> void:
	await transition_manager.fade_in()
	
	if current_game:
		current_game.queue_free()
	
	var game : Node = game_prefab.instantiate()
	current_game = game
	core.add_child(game)
	
	screen_shader_manager.show()
	
	await get_tree().create_timer(LOADING_TIME)
	
	await transition_manager.fade_out()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		load_game()
