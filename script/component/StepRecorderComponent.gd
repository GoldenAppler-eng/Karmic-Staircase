class_name StepRecorderComponent
extends Node

@export var target_brain : Brain

var recorded_frames : Array[BrainFrameData]

func _enter_tree() -> void:
	var node2d : Node2D = owner as Node2D

func _physics_process(delta: float) -> void:
	recorded_frames.append(record_brain())

func record_brain() -> BrainFrameData:
	var brain_frame_data : BrainFrameData = BrainFrameData.new()
	
	brain_frame_data.wants_movement = target_brain.wants_movement()
	brain_frame_data.wants_sprint = target_brain.wants_sprint()
	brain_frame_data.wants_attack = target_brain.wants_attack()
	brain_frame_data.wants_interact = target_brain.wants_interact()
	brain_frame_data.wants_use = target_brain.wants_use()
	brain_frame_data.wants_pickup = target_brain.wants_pickup()
	brain_frame_data.wants_drop = target_brain.wants_drop()
	brain_frame_data.movement_vector = target_brain.get_movement_vector()
	
	return brain_frame_data

func get_recorded_data() -> Array[BrainFrameData]:
	return recorded_frames.duplicate()
	
func clear() -> void:
	recorded_frames = []
