extends Menu

@export var revert_menu : RevertMenu

@onready var endings_back_button: Button = %EndingsBackButton

var _back : bool = false

func extra_init() -> void:
	endings_back_button.pressed.connect( _on_endings_back_button_pressed )

func enter() -> void:
	super()
	
	_back = false
	
func exit() -> void:
	super()

func process_frame(delta : float) -> Menu:
	if _back:
		return revert_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null

func _on_endings_back_button_pressed() -> void:
	_back = true
