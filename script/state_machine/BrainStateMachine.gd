class_name BrainStateMachine
extends Node

signal state_changed

@export var speech_text : SpeechText

@export var initial_state : BrainState

var current_state : BrainState

func init(p_brain : AIBrain, p_stat_data_component : StatDataComponent, p_pickup_item_component : PickupItemComponent, p_interacter_component : InteracterComponent, p_player_vision_component : PlayerVisionComponent, p_speech_text : SpeechText, p_level : Level) -> void:
	for state in get_children():
		(state as BrainState).init(p_brain, p_stat_data_component, p_pickup_item_component, p_interacter_component, p_player_vision_component, p_speech_text, p_level)

	change_state(initial_state)

func process_physics(delta : float) -> void:
	var next_state : BrainState = current_state.process_physics(delta)
	
	if next_state:
		change_state(next_state)

func change_state(next_state : BrainState) -> void:
	if current_state:
		current_state.exit()
		
		if not current_state == next_state:
			state_changed.emit()
	
	current_state = next_state
	current_state.enter()
	
		

func reset_state_machine() -> void:
	change_state(initial_state)
