class_name InteracterComponent
extends Area2D

var interactables_in_range : Array[InteractableComponent] = []
var interacter : Node2D

func init(p_interacter : Node2D) -> void:
	interacter = p_interacter
	
	area_entered.connect(_on_interact_area_entered)
	area_exited.connect(_on_interact_area_exited)

func interact_with_interactables() -> void:
	while(are_interactables() and not interactables_in_range[0]._enabled):
		interactables_in_range.pop_front()
	
	if are_interactables():
		interactables_in_range[0].interact.call(interacter)
	
func are_interactables() -> bool:
	return not interactables_in_range.is_empty()

func _on_interact_area_entered(area : Area2D) -> void:
	if area is InteractableComponent:
		if (area as InteractableComponent)._enabled:
			interactables_in_range.append(area)
	
func _on_interact_area_exited(area : Area2D) -> void:
	if area is InteractableComponent:
		interactables_in_range.append(area)
