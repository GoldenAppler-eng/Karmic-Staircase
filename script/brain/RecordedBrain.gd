class_name RecordedBrain
extends Brain

@export var pickup_item_component : PickupItemComponent

var recorded_brain_data : Array[BrainFrameData]
var recorded_item_data : Array[PickupFrameData]

var current_frame = 0

var _stop_play_recording : bool = false

func _physics_process(delta: float) -> void:
	if pickup_item_component.is_not_holding_item() and recorded_item_data[current_frame].has_item: 	
		_stop_play_recording = true
		
	if current_frame + 1 >= recorded_brain_data.size():
		_stop_play_recording = true
		
	if _stop_play_recording:
		return
	
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

func shut_off() -> void:
	_stop_play_recording = true
