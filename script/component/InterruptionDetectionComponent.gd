class_name InterruptionDetectionComponent
extends Node

@export var stat_data_component : StatDataComponent

signal interrupted

func emit_interrupted(see_player : bool = false, see_player_weapon : bool = false, see_dead_body : bool = false) -> void:
	if see_player:
		stat_data_component.change_desperation(GlobalConstants.SEE_PLAYER_DESPERATION_COST)
	
	if see_player_weapon:
		stat_data_component.change_desperation(GlobalConstants.SEE_PLAYER_WEAPON_DESPERATION_COST)
	
	if see_dead_body:
		stat_data_component.change_desperation(GlobalConstants.SEE_DEAD_BODY_DESPERATION_COST)
	
	interrupted.emit()
