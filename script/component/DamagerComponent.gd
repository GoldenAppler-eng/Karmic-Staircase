class_name DamagerComponent
extends Area2D

@export var reach : float = 0.4

func deal_damage() -> bool:	
	var dealt_damage : bool = false
	
	var rotation_tracker_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.ROTATIONTRACKER)
	
	for area in get_overlapping_areas():
		if not area is HurtboxComponent:
			continue
			
		if area.owner.has_meta(rotation_tracker_meta_name) and owner.has_meta(rotation_tracker_meta_name):			
			var attacker_rotation_tracker_component : RotationTrackerComponent = owner.get_meta(rotation_tracker_meta_name)
			var attacked_rotation_tracker_component : RotationTrackerComponent = area.owner.get_meta(rotation_tracker_meta_name)
		
			var attacker_vertical_coordinate : float = attacker_rotation_tracker_component.psuedo_vertical_coordinate
			var attacked_vertical_coordinate : float = attacked_rotation_tracker_component.psuedo_vertical_coordinate
			
			var vertical_distance : float = abs(attacker_vertical_coordinate - attacked_vertical_coordinate)
			
			print(vertical_distance)
			
			if vertical_distance > reach:
				continue
					
		var hurtbox_component : HurtboxComponent = area as HurtboxComponent
		hurtbox_component.get_hurt()
		dealt_damage = true
		
	return dealt_damage
