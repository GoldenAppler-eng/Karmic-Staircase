class_name MenuGameManager
extends Node2D

signal game_started

const PAUSE_TIME : float = 1

@onready var door: Door = %Door
@onready var room: Sprite2D = %Room

func _ready() -> void:
	door.entered.connect( _on_door_entered )
	
	room.frame = 0
	
func _input(event : InputEvent) -> void:
	if event.is_action_pressed("skip_opening"):
		game_started.emit()

func _on_door_entered() -> void:
	room.frame = 1
	
	await get_tree().create_timer(PAUSE_TIME).timeout
	
	game_started.emit()
