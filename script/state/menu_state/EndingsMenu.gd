extends Menu

@export var revert_menu : RevertMenu

@onready var endings_back_button: Button = %EndingsBackButton
@onready var endings_button_container: VBoxContainer = %EndingsButtonContainer

@onready var ending_explanation_container: MarginContainer = %EndingExplanationContainer

@onready var ending_name: RichTextLabel = %EndingName
@onready var ending_reason: Label = %EndingReason
@onready var ending_description: Label = %EndingDescription

var ending_buttons_dictionary : Dictionary = {}

var _back : bool = false
var _viewing_ending : bool = false

func extra_init() -> void:
	endings_back_button.pressed.connect( _on_endings_back_button_pressed )
	
	_initialize_endings_buttons()

func enter() -> void:
	super()
	
	_back = false
	_viewing_ending = false
	
	_view_ending_page(_viewing_ending)
	_check_endings_unlocked()
	
	set_game_paused(true)
	
func exit() -> void:
	super()
	
	set_game_paused(false)

func process_frame(delta : float) -> Menu:
	if _back and _viewing_ending:
		_viewing_ending = false
		_back = false
		
		_view_ending_page(_viewing_ending)
	
	if _back:
		return revert_menu
	
	return null
	
func process_physics(delta : float) -> Menu:
	return null

func process_input(event : InputEvent) -> Menu:
	return null

func _check_endings_unlocked() -> void:
	for ending in game_end_manager.get_endings_found_indices():
		(ending_buttons_dictionary[int(ending)] as Button).disabled = false

func _initialize_endings_buttons() -> void:
	for ending in game_end_manager.ENDINGS.values():
		var button : Button = Button.new()
		
		button.text = game_end_manager.ENDINGS.keys()[ending]
		
		var button_color : String = game_end_manager.ENDING_COLOR_DICTIONARY[ending]
		var hover_color : Color = Color8(175, 175, 175, 100)
		var pressed_color : Color = Color8(87, 87, 87, 100)
		var disabled_color : Color = Color8(100, 100, 100)
		
		button.add_theme_font_size_override("font_size", 8)
		
		button.add_theme_color_override("font_color", Color(button_color))
		button.add_theme_color_override("font_focus_color", Color(button_color))
		button.add_theme_color_override("font_hover_color", Color(button_color).blend(hover_color))
		button.add_theme_color_override("font_hover_pressed_color", Color(button_color).blend(hover_color))
		button.add_theme_color_override("font_pressed_color", Color(button_color).blend(pressed_color))
		button.add_theme_color_override("font_disabled_color", Color(disabled_color))
		
		button.disabled = true
		
		ending_buttons_dictionary[ending] = button
		
		endings_button_container.add_child(button)

		button.pressed.connect( _on_ending_button_pressed.bind(ending) )

func _view_ending_page(view : bool) -> void:
	if view:
		endings_button_container.visible = false
		ending_explanation_container.visible = true
	else:
		endings_button_container.visible = true
		ending_explanation_container.visible = false

func _on_ending_button_pressed(ending : int) -> void:
	_viewing_ending = true
	
	var ending_result : String = game_end_manager.get_ending_name(ending)
	var ending_color : String = game_end_manager.get_ending_color(ending)
	
	ending_name.text = "[color=" + ending_color + "]" + ending_result
	ending_reason.text = game_end_manager.get_ending_reason(ending)
	ending_description.text = game_end_manager.get_ending_description(ending)

	_view_ending_page(_viewing_ending)

func _on_endings_back_button_pressed() -> void:
	_back = true
