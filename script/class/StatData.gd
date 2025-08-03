class_name StatData
extends Resource

signal hunger_changed(change : float)
signal desperation_changed(change : float) 

const MIN_HUNGER : float = 0
const MAX_HUNGER : float = 100

const MIN_DESPERATION : float = 0
const MAX_DESPERATION : float = 100

@export var hunger : float = 100
@export var desperation : float = 0

func change_hunger(net_change : float) -> void:
	hunger += net_change
	
	hunger = clamp(hunger, MIN_HUNGER, MAX_HUNGER)
	
	hunger_changed.emit(net_change)
	
func change_desperation(net_change : float) -> void:
	desperation += net_change
	
	desperation = clamp(desperation, MIN_DESPERATION, MAX_DESPERATION)
	
	desperation_changed.emit(net_change)
