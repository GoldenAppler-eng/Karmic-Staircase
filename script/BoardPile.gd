extends RigidBody2D

@onready var interactable_component: InteractableComponent = %interactable_component

func _ready() -> void:
	interactable_component.interact = interact
	
func interact(interacter : Node2D) -> void:
	print(interacter.name)
