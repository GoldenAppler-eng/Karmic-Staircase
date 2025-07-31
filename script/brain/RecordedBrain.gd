class_name RecordedBrain
extends Brain

var recorded_brain_data : Array[BrainFrameData]
var current_frame = 0

func _physics_process(delta: float) -> void:
	current_frame += 1
	
func wants_movement() -> bool:
	return recorded_brain_data[current_frame].wants_movement

func wants_sprint() -> bool:
	return recorded_brain_data[current_frame].wants_sprint

func wants_attack() -> bool:
	return recorded_brain_data[current_frame].wants_attack

func wants_interact() -> bool:
	return recorded_brain_data[current_frame].wants_interact
	
func wants_use() -> bool:
	return recorded_brain_data[current_frame].wants_use
	
func wants_pickup() -> bool:
	return recorded_brain_data[current_frame].wants_pickup

func wants_drop() -> bool:
	return recorded_brain_data[current_frame].wants_drop

func get_movement_vector() -> Vector2:
	return recorded_brain_data[current_frame].movement_vector
