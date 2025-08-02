class_name Menu
extends Control

func init() -> void:
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
