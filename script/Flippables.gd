class_name Flippables
extends Node2D

func set_flip_h(flipped : bool) -> void:
	scale.x = -1 if flipped else 1
