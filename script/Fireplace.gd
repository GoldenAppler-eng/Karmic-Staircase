class_name Fireplace
extends Node2D

const FIREPLACE_MAX_FRAME : int = 3

const MIN_FUEL : float = 0
const MAX_FUEL : float = 100

var fuel : float:
	set(value):
		fuel = value
		fuel = clamp(fuel, MIN_FUEL, MAX_FUEL)
		_update_sprite_animation(fuel, MAX_FUEL, FIREPLACE_MAX_FRAME)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	fuel = MAX_FUEL

func fuel_fire(fuel_amount : float) -> void:
	fuel = fuel + fuel_amount

func _update_sprite_animation(current_value : int, max_value : int, max_frame : int) -> void:
	sprite_2d.frame =  min(FIREPLACE_MAX_FRAME, max_frame - float(current_value) / max_value * max_frame)
	
	gpu_particles_2d.emitting = not sprite_2d.frame == FIREPLACE_MAX_FRAME
