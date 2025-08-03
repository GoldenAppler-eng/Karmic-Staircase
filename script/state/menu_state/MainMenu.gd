extends Menu

@export var idle_menu : Menu
@export var quit_menu : Menu

@onready var start_game_button: Button = %StartGameButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_game_button: Button = %QuitGameButton

var _start_game : bool = false
var _quit_game : bool = false

func extra_init() -> void:
	start_game_button.pressed.connect( _on_start_button_pressed )
	settings_button.pressed.connect( _on_settings_button_pressed )
	quit_game_button.pressed.connect( _on_quit_button_pressed )

func enter() -> void:
	super()	
	
	_start_game = false
	_quit_game = false
	start_game_button.grab_focus()
	
func exit() -> void:
	super()

func process_frame(delta : float) -> Menu:
	if _start_game:
		return idle_menu
		
	if _quit_game:
		return quit_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null

func _on_start_button_pressed() -> void:
	_start_game = true
	
func _on_settings_button_pressed() -> void:
	pass
	
func _on_quit_button_pressed() -> void:
	_quit_game = true
