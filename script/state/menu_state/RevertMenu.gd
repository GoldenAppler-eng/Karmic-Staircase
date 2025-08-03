class_name RevertMenu
extends Menu

var previous_menu : Menu

func enter() -> void:
	super()
	
func exit() -> void:
	super()
	
	previous_menu = null

func process_frame(delta : float) -> Menu:
	if previous_menu:
		return previous_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null

func set_previous_menu(menu : Menu) -> void:
	previous_menu = menu
