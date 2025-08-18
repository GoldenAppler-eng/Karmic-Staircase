extends Menu

@export var revert_menu : RevertMenu

@export var page_one : Control
@export var page_two : Control
@export var page_three : Control

@onready var tutorial_back_button: Button = %TutorialBackButton
@onready var previous_button: Button = %PreviousButton
@onready var next_button: Button = %NextButton

var _current_page : int = 0

var _back : bool = false

func extra_init() -> void:
	tutorial_back_button.pressed.connect( _on_tutorial_back_button_pressed )

	previous_button.pressed.connect( _change_page.bind(-1) )
	next_button.pressed.connect( _change_page.bind(1) )

func enter() -> void:
	super()
	
	_back = false
	
	_current_page = 0
	
	_show_page(_current_page)
	
	set_game_paused(true)
	
func exit() -> void:
	super()
	
	set_game_paused(false)

func process_frame(delta : float) -> Menu:
	if _back:
		return revert_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null

func _show_page(page : int) -> void:
	match page:
		0:
			page_one.visible = true
			page_two.visible = false
			page_three.visible = false
		1:
			page_one.visible = false
			page_two.visible = true
			page_three.visible = false
		2:
			page_one.visible = false
			page_two.visible = false
			page_three.visible = true

func _change_page(change : int) -> void:
	_current_page = (_current_page + change + 3) % 3
	
	_show_page(_current_page)	

func _on_tutorial_back_button_pressed() -> void:
	_back = true
