class_name PickupableItemData
extends Resource

@export var name : String
@export var can_use_to_attack : bool

@export var hold_sprite : Texture2D
@export var world_sprite : Texture2D

@export var hold_offset : Vector2
@export var scale : Vector2 = Vector2(1, 1)

var use : Callable
