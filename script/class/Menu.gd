class_name Menu
extends Control

var game_loading_manager : GameLoadingManager
var game_end_manager : GameEndManager

func init(p_game_loading_manager : GameLoadingManager, p_game_end_manger : GameEndManager) -> void:
	visible = false
	extra_init()
	
	game_loading_manager = p_game_loading_manager
	game_end_manager = p_game_end_manger

func extra_init() -> void:
	pass

func enter() -> void:
	visible = true
	
func exit() -> void:
	visible = false

func process_frame(delta : float) -> Menu:
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null

func set_game_paused(paused : bool) -> void:
	get_tree().paused = paused
