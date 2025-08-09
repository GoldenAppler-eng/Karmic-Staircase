class_name Flippables
extends Node2D

signal flipped(value : bool)

func set_flip_h(flip : bool) -> void:
	scale.x = -1 if flip else 1
	flipped.emit(flip)
