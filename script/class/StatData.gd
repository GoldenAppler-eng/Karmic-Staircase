class_name StatData
extends Resource

const MIN_HUNGER : float = 0
const MAX_HUNGER : float = 100

const MIN_DESPERATION : float = 0
const MAX_DESPERATION : float = 100

@export var hunger : float = 100
@export var desperation : float = 0

func change_hunger(net_change : float) -> void:
	hunger += net_change
	
	hunger = clamp(hunger, MIN_HUNGER, MAX_HUNGER)
		
func change_desperation(net_change : float) -> void:
	desperation += net_change
	
	desperation = clamp(desperation, MIN_DESPERATION, MAX_DESPERATION)
	
