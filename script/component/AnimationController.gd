class_name AnimationController
extends Node

signal animation_finished(anim_name : StringName)

@export var anim_player : AnimationPlayer

@export var movement_component : MovementComponent
@export var pickup_item_component : PickupItemComponent
@export var stat_data_component : StatDataComponent

@export var flippables : Flippables

func init() -> void:
	anim_player.animation_finished.connect(_on_animation_player_finished)

func process_physics(delta : float) -> void:
	flippables.set_flip_h(not movement_component.last_facing_right)

func play_animation(anim_name : StringName) -> void:		
	match anim_name:
		"idle":
			if pickup_item_component.is_not_holding_item():
				anim_player.play("idle")
			else:
				anim_player.play("idle_hold")
		"move":
			if pickup_item_component.is_not_holding_item():
				anim_player.play("walk")
			else:
				anim_player.play("walk_hold")
		"sprint":
			if pickup_item_component.is_not_holding_item():
				anim_player.play("sprint")
			else:
				anim_player.play("sprint_hold")
		_:
			anim_player.play(anim_name)

func _on_animation_player_finished(anim_name : StringName) -> void:
	animation_finished.emit(anim_name)
