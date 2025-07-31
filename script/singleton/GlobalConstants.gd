extends Node

enum COMPONENT { PICKUPITEM, STATDATA, ROTATIONTRACKER }

const COMPONENT_DICTIONARY : Dictionary = {
	COMPONENT.PICKUPITEM : "pickup_item_component",
	COMPONENT.STATDATA : "stat_data_component",
	COMPONENT.ROTATIONTRACKER : "rotation_tracker_component"
}

func get_component_name(component : COMPONENT) -> StringName:
	return COMPONENT_DICTIONARY[component]
