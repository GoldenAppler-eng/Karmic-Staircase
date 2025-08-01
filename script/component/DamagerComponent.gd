class_name DamagerComponent
extends Area2D

func deal_damage() -> void:	
	for area in get_overlapping_areas():
		if area is HurtboxComponent:
			var hurtbox_component : HurtboxComponent = area as HurtboxComponent
			hurtbox_component.get_hurt()
