extends Menu

@export var revert_menu : Menu

@onready var settings_back_button: Button = %SettingsBackButton

var _go_back : bool = false

func extra_init() -> void:
	settings_back_button.pressed.connect(_on_back_button_pressed)

func enter() -> void:
	super()
	
	_go_back = false
	set_game_paused(true)
	
func exit() -> void:
	super()
	set_game_paused(false)

func process_frame(delta : float) -> Menu:
	if _go_back:
		return revert_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	if event.is_action_pressed("pause_game"):
		return revert_menu
	
	return null

func _on_back_button_pressed() -> void:
	_go_back = true
