class_name GameLoadingManager
extends Node

const LOADING_TIME : float = 1

const game_prefab : PackedScene = preload("res://scene/game.tscn")
const menu_game_prefab : PackedScene = preload("res://scene/menu_game.tscn")

@export var core : Node
@export var transition_manager : TransitionManager
@export var screen_shader_manager : ScreenShaderManager
@export var game_end_manager : GameEndManager

var current_game : Node

var menu_game : MenuGameManager

var first_time_playing : bool = true

func kill_game() -> void:	
	if current_game:
		first_time_playing = false
		
		current_game.queue_free()
	
	game_end_manager.kill_game()

func load_menu_game() -> void:
	screen_shader_manager.show_vignette_only()
	
	var menu_game_instance : MenuGameManager = menu_game_prefab.instantiate()
	
	menu_game = menu_game_instance
	core.add_child(menu_game)

	menu_game.game_started.connect( _on_game_started )

	await get_tree().create_timer(LOADING_TIME).timeout

func load_game() -> void:
	game_end_manager.kill_game()

	await transition_manager.fade_in()
	
	if current_game:
		current_game.queue_free()
	
	if menu_game:
		menu_game.queue_free()
		menu_game = null
	
	var game : Node = game_prefab.instantiate()
	current_game = game
	core.add_child(game)
	
	game_end_manager.start_game(current_game)
	
	screen_shader_manager.show()
	
	await get_tree().create_timer(LOADING_TIME).timeout
	
	await transition_manager.fade_out()

func call_transition_fade_in() -> void:
	await transition_manager.fade_in()
	
func call_transition_fade_out() -> void:
	await transition_manager.fade_out()

func hide_screen_shaders() -> void:
	screen_shader_manager.hide()

func _on_game_started() -> void:
	await load_game()
