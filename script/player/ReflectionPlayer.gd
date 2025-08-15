extends Node2D

@export var follow_player : CharacterBody2D

@export var mirror_axis_y : Marker2D

@onready var flippables: Flippables = %flippables
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	var anim_controller : AnimationController = follow_player.find_child("animation_controller") as AnimationController
	anim_controller.animation_played.connect(_on_animation_played)

	var player_flippables : Flippables = follow_player.find_child("flippables") as Flippables
	player_flippables.flipped.connect(_on_flipped)

func _physics_process(delta: float) -> void:
	global_position.x = follow_player.global_position.x
	
	var player_distance_from_axis_y : float = follow_player.global_position.y - mirror_axis_y.global_position.y
	
	global_position.y = mirror_axis_y.global_position.y - player_distance_from_axis_y

func _on_animation_played(anim_name : StringName) -> void:
	animation_player.play(anim_name)

func _on_flipped(value : bool) -> void:
	flippables.set_flip_h(value)
