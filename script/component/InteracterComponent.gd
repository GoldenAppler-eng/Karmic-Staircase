class_name InteracterComponent
extends Area2D

var interactables_in_range : Array[InteractableComponent] = []
var interacter : Node2D

func init(p_interacter : Node2D) -> void:
	owner.set_meta(GlobalConstants.get_component_name(GlobalConstants.COMPONENT.INTERACTER), self)
	
	interacter = p_interacter
	
	area_entered.connect(_on_interact_area_entered)
	area_exited.connect(_on_interact_area_exited)

func interact_with_interactables() -> void:
	while(are_interactables() and not interactables_in_range[0]._enabled):
		interactables_in_range.pop_front()
	
	interactables_in_range.sort_custom(sort_by_priority)
	
	if are_interactables():
		interactables_in_range[0].interact.call(interacter)
	
func sort_by_priority(a : InteractableComponent, b : InteractableComponent) -> bool:
	return a.interact_priority > b.interact_priority

func are_interactables() -> bool:
	return not interactables_in_range.is_empty()

func get_interactables() -> Array[InteractableComponent]:
	return interactables_in_range

func _on_interact_area_entered(area : Area2D) -> void:
	if area is InteractableComponent:
		if (area as InteractableComponent)._enabled:
			interactables_in_range.append(area)
	
func _on_interact_area_exited(area : Area2D) -> void:
	if area is InteractableComponent:
		interactables_in_range.erase(area)
