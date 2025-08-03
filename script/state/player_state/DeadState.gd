extends State

func extra_init() -> void:
	pass
	
func enter() -> void:
	pickup_item_component.drop_item()
	animation_controller.play_animation("dead")
	
	print("is dead")
	
func exit() -> void:
	hurtbox_component.revive()	
	
func process_physics(delta : float) -> State:
	return null
	
func process_frame(delta : float) -> State:
	return null
