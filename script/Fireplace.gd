class_name Fireplace
extends Node2D

signal burnout

const tooltip_list : Array[String] = [
	"Its dying",
	"Its dim",
	"Its warm",
	"Its bright",
	"Its hot",
	]

const FUEL_BURNOUT_AMOUNT : float = 2
const FIREPLACE_MAX_FRAME : int = 3

const MAX_LIGHT_ENERGY : float = 0.7
const MIN_LIGHT_ENERGY : float = 0

const MIN_FUEL : float = 0
const MAX_FUEL : float = 100

var boards_put_in_fire : int = 0

var fuel : float:
	set(value):
		fuel = value
		fuel = clamp(fuel, MIN_FUEL, MAX_FUEL)
		_update_sprite_animation(fuel, MAX_FUEL, FIREPLACE_MAX_FRAME)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var tool_tip_activation_component: ToolTipActivationComponent = $tool_tip_activation_component

@onready var burn_sound: AudioStreamPlayer2D = $burn_sound

func _ready() -> void:
	fuel = MAX_FUEL

func fuel_fire(fuel_amount : float) -> void:
	fuel = fuel + fuel_amount
	
	if fuel_amount > 0:
		boards_put_in_fire += 1
		burn_sound.play()

func _update_sprite_animation(current_value : int, max_value : int, max_frame : int) -> void:
	sprite_2d.frame =  min(max_frame - 1, max_frame - float(current_value) / max_value * max_frame)
	
	gpu_particles_2d.emitting = not sprite_2d.frame == FIREPLACE_MAX_FRAME
	point_light_2d.energy = float(current_value) / max_value * (MAX_LIGHT_ENERGY - MIN_LIGHT_ENERGY) + MIN_LIGHT_ENERGY

	var tip_index : int = min(float(current_value) / max_value * tooltip_list.size(), tooltip_list.size() - 1)
	tool_tip_activation_component.set_tooltip(tooltip_list[tip_index])	

func _on_fuel_burnout_timer_timeout() -> void:
	fuel = fuel - FUEL_BURNOUT_AMOUNT 

	if fuel == 0:
		burnout.emit()
