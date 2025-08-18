extends Control

@export var game_loading_manager : GameLoadingManager
@export var game_end_manager : GameEndManager

@export var initial_menu : Menu
var current_menu : Menu 

var sfx_player_dict : Dictionary = {
	"ui_hover" : AudioStreamPlayer.new(),	
	"ui_pressed" : AudioStreamPlayer.new(),
}

func _ready() -> void:	
	for node : Node in get_children():
		if node is Menu:
			var menu : Menu = node as Menu
			menu.init(game_loading_manager, game_end_manager)
	
	change_menu(initial_menu)
	
	create_sfx_children()
	install_sfx(self)

func _process(delta : float) -> void:
	var next_menu : Menu = current_menu.process_frame(delta)
	
	if next_menu:
		change_menu(next_menu)

func _physics_process(delta: float) -> void:
	var next_menu : Menu = current_menu.process_physics(delta)
	
	if next_menu:
		change_menu(next_menu)

func _input(event: InputEvent) -> void:
	var next_menu : Menu = current_menu.process_input(event)
	
	if next_menu:
		change_menu(next_menu)

func create_sfx_children() -> void:
	for sfx : String in sfx_player_dict.keys():
		var stream_player : AudioStreamPlayer = sfx_player_dict[sfx]
		stream_player.stream = load("res://audio/menu/" + sfx + ".wav")

		stream_player.bus = "Sfx"
		stream_player.volume_db = -5.0
		add_child(stream_player)

func install_sfx(node : Node) -> void:
	for i in node.get_children():
		if i is Button:
			var button : Button = i as Button
			
			button.mouse_entered.connect( ui_sfx_play.bind("ui_hover") )
			button.focus_entered.connect( ui_sfx_play.bind("ui_hover") )			
			button.pressed.connect( ui_sfx_play.bind("ui_pressed") )
		
		if i is HSlider:
			var h_slider : HSlider = i as HSlider
			
			h_slider.mouse_entered.connect(ui_sfx_play.bind("ui_hover"))
			h_slider.focus_entered.connect(ui_sfx_play.bind("ui_hover"))
			h_slider.drag_started.connect(ui_sfx_play.bind("ui_pressed"))

		install_sfx(i)

func ui_sfx_play(sfx : String) -> void:
	var stream_player : AudioStreamPlayer = sfx_player_dict[sfx]
	stream_player.play()

func change_menu(next_menu : Menu) -> void:
	if current_menu:
		current_menu.exit()
	
	current_menu = next_menu
	current_menu.enter()
