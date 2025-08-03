extends Menu

@export var restart_menu : Menu
@export var main_menu : Menu
@export var quit_menu : Menu

@onready var end_restart_button: Button = %EndRestartButton
@onready var end_main_menu_button: Button = %EndMainMenuButton
@onready var end_quit_game: Button = %EndQuitGame

var _restart : bool = false
var _back_to_main_menu : bool = false
var _quit_game : bool = false

func extra_init() -> void:
	end_restart_button.pressed.connect( _on_restart_button_pressed )
	end_main_menu_button.pressed.connect( _on_main_menu_button_pressed )
	end_quit_game.pressed.connect( _on_quit_button_pressed )

func enter() -> void:
	super()
	
	_restart = false
	_back_to_main_menu = false
	_quit_game = false
	
	end_restart_button.grab_focus()
	
func exit() -> void:
	super()

func process_frame(delta : float) -> Menu:
	if _quit_game:
		return quit_menu
		
	if _back_to_main_menu:
		return main_menu
	
	if _restart:
		return restart_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null

func _on_restart_button_pressed() -> void:
	_restart = true
	
func _on_main_menu_button_pressed() -> void:
	_back_to_main_menu = true
	
func _on_quit_button_pressed() -> void:
	_quit_game = true
