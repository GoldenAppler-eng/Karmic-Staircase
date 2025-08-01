extends State

func extra_init() -> void:
	pass
	
func enter() -> void:
	pickup_item_component.drop_item()
	
func exit() -> void:
	pass	
	
func process_physics(delta : float) -> State:
	return null
	
func process_frame(delta : float) -> State:
	return null
