extends Menu

@export var idle_menu : Menu

func enter() -> void:
	super()
	
func exit() -> void:
	super()

func process_frame(delta : float) -> Menu:
	game_loading_manager.load_game()
	
	return idle_menu
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null
