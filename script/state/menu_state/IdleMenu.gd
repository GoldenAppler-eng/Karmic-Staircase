extends Menu

@export var pause_menu : Menu
@export var game_end_menu : Menu

func enter() -> void:
	super()	
		
func exit() -> void:
	super()

func process_frame(delta : float) -> Menu:
	return null
	
func process_physics(delta : float) -> Menu:
	if game_end_manager.get_ended():
		return game_end_menu
	
	return null

func process_input(event : InputEvent) -> Menu:
	if event.is_action_pressed("pause_game"):
		return pause_menu
	
	return null
