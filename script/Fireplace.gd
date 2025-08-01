class_name Fireplace
extends Node2D

const MIN_FUEL : float = 0
const MAX_FUEL : float = 100

var fuel : float = MAX_FUEL

func fuel_fire(fuel_amount : float) -> void:
	fuel += fuel_amount
	
	fuel = clamp(fuel, MIN_FUEL, MAX_FUEL)
