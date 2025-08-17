extends Menu

@export var main_menu_animation : AnimationPlayer

@export var idle_menu : Menu
@export var tutorial_menu : Menu
@export var settings_menu : Menu
@export var quit_menu : Menu
@export var endings_menu : Menu

@export var revert_menu : RevertMenu

@onready var start_game_button: Button = %StartGameButton
@onready var tutorial_button: Button = %TutorialButton
@onready var endings_button: Button = %EndingsButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_game_button: Button = %QuitGameButton

var _start_game : bool = false
var _go_to_tutorial : bool = false
var _go_to_endings : bool = false
var _go_to_settings : bool = false
var _quit_game : bool = false

func extra_init() -> void:
	start_game_button.pressed.connect( _on_start_button_pressed )
	tutorial_button.pressed.connect( _on_tutorial_button_pressed )
	endings_button.pressed.connect( _on_endings_button_pressed )
	settings_button.pressed.connect( _on_settings_button_pressed )
	quit_game_button.pressed.connect( _on_quit_button_pressed )

func enter() -> void:
	super()	
	
	game_loading_manager.hide_screen_shaders()
	
	game_loading_manager.call_transition_fade_out()
	game_loading_manager.kill_game()
	
	_start_game = false
	_go_to_tutorial = false
	_go_to_endings = false
	_go_to_settings = false
	_quit_game = false
	
	start_game_button.grab_focus()
	
	main_menu_animation.play("start")
	
func exit() -> void:
	super()

func process_frame(delta : float) -> Menu:
	if _start_game:
		game_loading_manager.load_menu_game()
		return idle_menu
	
	if _go_to_tutorial:
		revert_menu.set_previous_menu(self)
		return tutorial_menu
	
	if _go_to_endings:
		revert_menu.set_previous_menu(self)
		
		return endings_menu
	
	if _go_to_settings:
		revert_menu.set_previous_menu(self)
		
		return settings_menu	
		
	if _quit_game:
		return quit_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null

func _on_start_button_pressed() -> void:
	_start_game = true

func _on_tutorial_button_pressed() -> void:
	_go_to_tutorial = true

func _on_endings_button_pressed() -> void:
	_go_to_endings = true
	
func _on_settings_button_pressed() -> void:
	_go_to_settings = true
	
func _on_quit_button_pressed() -> void:
	_quit_game = true
