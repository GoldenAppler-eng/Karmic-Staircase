extends Brain

func wants_movement() -> bool:
	var horizontal_direction : float = Input.get_axis("move_left", "move_right")
	var vertical_direction : float = Input.get_axis("move_up", "move_down")
	
	return horizontal_direction or vertical_direction 

func wants_sprint() -> bool:
	return Input.is_action_pressed("sprint")

func wants_attack() -> bool:
	return Input.is_action_just_pressed("attack")
	
func wants_interact() -> bool:
	return Input.is_action_just_pressed("interact")

func wants_use() -> bool:
	return Input.is_action_just_pressed("use")
	
func wants_pickup() -> bool:
	return Input.is_action_just_pressed("pickup")

func wants_drop() -> bool:
	return Input.is_action_just_pressed("drop_item")

func get_movement_vector() -> Vector2:
	var horizontal_direction : float = Input.get_axis("move_left", "move_right")
	var vertical_direction : float = Input.get_axis("move_up", "move_down")
	
	return Vector2(horizontal_direction, vertical_direction)
