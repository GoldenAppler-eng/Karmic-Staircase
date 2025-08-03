extends State

func extra_init() -> void:
	pass
	
func enter() -> void:
	pickup_item_component.drop_item()
	animation_controller.play_animation("dead")
	stat_data_component.is_dead = true
	hurtbox_component.disable_hurtbox()
	
func exit() -> void:
	hurtbox_component.revive()	
	stat_data_component.is_dead = false
	hurtbox_component.enable_hurtbox()

	
func process_physics(delta : float) -> State:
	return null
	
func process_frame(delta : float) -> State:
	return null
