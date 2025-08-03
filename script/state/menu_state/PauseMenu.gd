extends Menu

@export var idle_menu : Menu
@export var restart_menu : Menu
@export var settings_menu : Menu
@export var main_menu : Menu
@export var quit_menu : Menu

@export var revert_menu : RevertMenu

@onready var resume_button: Button = %ResumeButton
@onready var to_settings_button: Button = %ToSettingsButton
@onready var restart_button: Button = %RestartButton
@onready var main_menu_button: Button = %MainMenuButton
@onready var in_quit_game_button: Button = %InQuitGameButton

var _resume : bool = false
var _go_to_settings : bool = false
var _restart : bool = false
var _back_to_main_menu : bool = false
var _quit_game : bool = false

func extra_init() -> void:
	resume_button.pressed.connect( _on_resume_button_pressed )
	to_settings_button.pressed.connect( _on_settings_button_pressed )
	restart_button.pressed.connect( _on_restart_button_pressed )
	main_menu_button.pressed.connect( _on_main_menu_button_pressed )
	in_quit_game_button.pressed.connect( _on_quit_button_pressed )

func enter() -> void:
	super()
	
	set_game_paused(true)
	resume_button.grab_focus()
	
	_resume = false
	_restart = false
	_go_to_settings = false
	_back_to_main_menu = false
	_quit_game = false
	
func exit() -> void:
	super()

	set_game_paused(false)

func process_frame(delta : float) -> Menu:
	if _quit_game:
		return quit_menu
		
	if _go_to_settings:
		revert_menu.set_previous_menu(self)
		return settings_menu
		
	if _restart:
		return restart_menu
		
	if _back_to_main_menu:
		game_loading_manager.call_transition_fade_in()
		return main_menu
	
	if _resume:
		return idle_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	if event.is_action_pressed("pause_game"):
		_resume = true
	
	return null

func _on_resume_button_pressed() -> void:
	_resume = true
	
func _on_settings_button_pressed() -> void:
	_go_to_settings = true

func _on_restart_button_pressed() -> void:
	_restart = true
	
func _on_main_menu_button_pressed() -> void:
	_back_to_main_menu = true
	
func _on_quit_button_pressed() -> void:
	_quit_game = true
