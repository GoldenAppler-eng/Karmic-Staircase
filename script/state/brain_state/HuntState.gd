extends BrainState

var dialogue_options : Array[String] = [
	"Where are you?",
	"Come out...come out...",
	"Please don't hide.",
	"Here? There?",
	"Where would I hide?"
]

@export var chase_player_state : BrainState
@export var dead_state : BrainState

@export var only_hunt_living : bool = true

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain._wants_sprint = false
	
	brain.set_target_position(level.staircase_top.global_position)
	
	speech_text.say(dialogue_options.pick_random())
	
func exit() -> void:
	brain._wants_movement = false

func process_physics(delta : float) -> BrainState:
	if stat_data_component.is_dead:
		return dead_state
	
	if player_vision_component.get_number_of_seen_player() > 0:
		brain.target_player = player_vision_component.get_closest_player(true)
		return chase_player_state
		
	if not only_hunt_living:
		if player_vision_component.get_number_of_seen_player() > 0 or player_vision_component.get_number_of_dead_bodies_seen() > 0:
			brain.target_player = player_vision_component.get_closest_player()
			return chase_player_state
	
	return null
	
