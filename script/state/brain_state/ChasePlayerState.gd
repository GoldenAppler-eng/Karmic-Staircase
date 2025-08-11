extends BrainState

@export var run_state : BrainState
@export var hunt_state : BrainState
@export var calm_state : BrainState

@export var dead_state : BrainState

@export var damager_component : DamagerComponent

@export var eerie_sfx_player : AudioStreamPlayer2D

func extra_init() -> void:
	pass

func enter() -> void:
	brain._wants_movement = true
	brain._wants_sprint = true
	
	brain.find_target_player()
	
	speech_text.say("Get over here")
	
	if eerie_sfx_player:
		eerie_sfx_player.play()
	
func exit() -> void:
	brain._wants_movement = false
	brain._wants_attack = false
	brain._wants_sprint = false

func process_physics(delta : float) -> BrainState:
	if stat_data_component.is_dead:
		return dead_state
	
	if pickup_item_component.is_not_holding_item():
		return calm_state

	if not brain.target_player:
		return hunt_state
	
	brain.find_target_player()
	
	brain._wants_attack = damager_component.has_hurtbox_in_range()
		
	return null
	
