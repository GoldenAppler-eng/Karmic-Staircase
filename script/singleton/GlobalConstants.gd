extends Node

# Desperation costs
const TAKE_CAKE_DESPERATION_COST : float = 5
const EAT_CAKE_DESPERATION_COST : float = 15

const TAKE_BOARD_DESPERATION_COST : float = 30
const BURN_BOARD_DESPERATION_COST : float = -15

const ATTACK_HIT_DESPERATION_COST : float = 50

const DROP_ITEM_DESPERATION_COST : float = 10

const SEE_PLAYER_DESPERATION_COST : float = 10
const SEE_PLAYER_WEAPON_DESPERATION_COST : float = 40
const SEE_DEAD_BODY_DESPERATION_COST : float = 100

# Hunger costs
const IDLE_HUNGER_COST : float = 1
const MOVE_HUNGER_COST : float = 5
const SPRINT_HUNGER_COST : float = 15

# Refill values
const CAKE_HUNGER_REFILL : float = 30
const BOARD_FUEL_VALUE : float = 50

# Desperation thresholds
const PANIC_DESPERATION_THRESHOLD : float = 50
const FIND_WEAPON_DESPERATION_THRESHOLD : float = 80

const EVIL_SPAWN_DESPERATION_THRESHOLD : float = 90

# Component dictionary
enum COMPONENT { PICKUPITEM, STATDATA, ROTATIONTRACKER, HURTBOX, INTERACTER }

const COMPONENT_DICTIONARY : Dictionary = {
	COMPONENT.PICKUPITEM : "pickup_item_component",
	COMPONENT.STATDATA : "stat_data_component",
	COMPONENT.ROTATIONTRACKER : "rotation_tracker_component",
	COMPONENT.HURTBOX : "hurt_box_component",
	COMPONENT.INTERACTER : "interacter_component"
}

func get_component_name(component : COMPONENT) -> StringName:
	return COMPONENT_DICTIONARY[component]
