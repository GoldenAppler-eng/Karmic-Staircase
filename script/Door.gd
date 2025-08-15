class_name Door
extends Node2D

signal entered

@onready var open_door_sfx: AudioStreamPlayer = %OpenDoorSfx
@onready var interactable_component: InteractableComponent = %interactable_component

func _ready() -> void:
	interactable_component.interact = enter_door
	
func enter_door(interacter : Node2D) -> void:
	entered.emit()
	interactable_component.set_enabled(false)
	
	open_door_sfx.play()
