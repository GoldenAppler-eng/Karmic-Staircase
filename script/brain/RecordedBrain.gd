class_name RecordedBrain
extends Brain

@export var interruption_detection_component : InterruptionDetectionComponent
@export var player_vision_component : PlayerVisionComponent
@export var pickup_item_component : PickupItemComponent

var recorded_brain_data : Array[BrainFrameData]
var recorded_item_data : Array[PickupFrameData]

var current_frame = 0

var _stop_play_recording : bool = false

func _physics_process(delta: float) -> void:
	if _stop_play_recording:
		return
	
	if player_vision_component.get_number_of_seen_player() > recorded_brain_data[current_frame].number_of_players_seen:		
		_stop_play_recording = true
		
		if player_vision_component.any_player_has_weapon():
			interruption_detection_component.emit_interrupted(true, true)
		else:
			interruption_detection_component.emit_interrupted(true)

	if pickup_item_component.is_not_holding_item() and recorded_item_data[current_frame].has_item: 	
		_stop_play_recording = true
		interruption_detection_component.emit_interrupted()
		
	if current_frame + 1 >= recorded_brain_data.size():
		_stop_play_recording = true
		interruption_detection_component.emit_interrupted()
				
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
