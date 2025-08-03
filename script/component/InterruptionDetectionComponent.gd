class_name InterruptionDetectionComponent
extends Node

const SEE_PLAYER_DESPERATION : float = 10
const SEE_PLAYER_WEAPON_DESPERATION : float = 40
const SEE_DEAD_BODY_DESPERATION : float = 100

@export var stat_data_component : StatDataComponent

signal interrupted

func emit_interrupted(see_player : bool = false, see_player_weapon : bool = false, see_dead_body : bool = false) -> void:
	if see_player:
		stat_data_component.change_desperation(SEE_PLAYER_DESPERATION)
	
	if see_player_weapon:
		stat_data_component.change_desperation(SEE_PLAYER_WEAPON_DESPERATION)
	
	if see_dead_body:
		stat_data_component.change_desperation(SEE_DEAD_BODY_DESPERATION)
	
	interrupted.emit()
