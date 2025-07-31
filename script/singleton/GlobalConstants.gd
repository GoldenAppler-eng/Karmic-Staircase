extends Node

enum COMPONENT { PICKUPITEM }

const COMPONENT_DICTIONARY : Dictionary = {
	COMPONENT.PICKUPITEM : "pickup_item_component"
}

func get_component_name(component : COMPONENT) -> StringName:
	return COMPONENT_DICTIONARY[component]
