class_name PlayerVisionComponent
extends Area2D

@export var fov : float = 0
@export var vertical_fov : float = 0

var ignore_player : CharacterBody2D
var movement_component : MovementComponent
var rotation_tracker_component : RotationTrackerComponent

var players_in_area : Array[CharacterBody2D]

func init(p_ignore_player : CharacterBody2D, p_movement_component : MovementComponent, p_rotation_tracker_component : RotationTrackerComponent) -> void:
	ignore_player = p_ignore_player
	movement_component = p_movement_component
	rotation_tracker_component = p_rotation_tracker_component
	
	body_entered.connect(_on_player_entered_area)
	body_exited.connect(_on_player_exited_area)

func get_number_of_seen_player() -> int:
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	
	var num_of_players_seen : int = 0
	
	var forward : Vector2 = Vector2(10, 0) if not movement_component.last_facing_right else Vector2(-10, 0)
	
	for player in players_in_area:
		if player.has_meta(stat_meta_name):
			var stat_data_component : StatDataComponent = player.get_meta(stat_meta_name) as StatDataComponent
		
			if stat_data_component.is_dead:
				continue
		
		var to_player : Vector2 = player.global_position - global_position
		var dot : float = forward.dot(to_player)
		
		if dot <= fov and player_in_vertical_range(player):
			num_of_players_seen += 1
			
	return num_of_players_seen
	
func get_number_of_dead_bodies_seen() -> int:
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	
	var num_of_players_seen : int = 0
	
	var forward : Vector2 = Vector2(10, 0) if not movement_component.last_facing_right else Vector2(-10, 0)
	
	for player in players_in_area:
		if player.has_meta(stat_meta_name):
			var stat_data_component : StatDataComponent = player.get_meta(stat_meta_name) as StatDataComponent
		
			if not stat_data_component.is_dead:
				continue
		
		var to_player : Vector2 = player.global_position - global_position
		var dot : float = forward.dot(to_player)
		
		if dot <= fov and player_in_vertical_range(player):
			num_of_players_seen += 1
			
	return num_of_players_seen

func _on_player_entered_area(body : Node2D) -> void:
	if body == ignore_player:
		return
		
	players_in_area.append(body)
	
func _on_player_exited_area(body : Node2D) -> void:
	if body == ignore_player:
		return
	
	players_in_area.erase(body)

func get_closest_player(need_living : bool = false) -> CharacterBody2D:
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	
	var min_distance : float = 99999
	var closest_player : CharacterBody2D = null
		
	var forward : Vector2 = Vector2(10, 0) if not movement_component.last_facing_right else Vector2(-10, 0)
	
	for player in players_in_area:
		var to_player : Vector2 = player.global_position - global_position
		var dot : float = forward.dot(to_player)
		
		if need_living:
			if player.has_meta(stat_meta_name):
				var stat_data_component : StatDataComponent = player.get_meta(stat_meta_name) as StatDataComponent
			
				if stat_data_component.is_dead:
					continue
		
		if dot > fov:
			continue
			
		if not player_in_vertical_range(player):
			continue
			
		var distance : float = to_player.length()
		
		if distance < min_distance:
			min_distance = distance
			closest_player = player
	
	return closest_player

func any_player_has_weapon() -> bool:
	var forward : Vector2 = Vector2(10, 0) if not movement_component.last_facing_right else Vector2(-10, 0)
	
	for player in players_in_area:
		var to_player : Vector2 = player.global_position - global_position
		var dot : float = forward.dot(to_player)
		
		if dot > fov:
			continue
		
		if not player_in_vertical_range(player):
			continue	
			
		if has_weapon(player):
			return true
			
	return false

func has_weapon(player : Node2D) -> bool:
	var pickup_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.PICKUPITEM)
	
	if not player.has_meta(pickup_meta_name):
		return false
	
	var pickup_item_component : PickupItemComponent = player.get_meta(pickup_meta_name) as PickupItemComponent
	
	if pickup_item_component.is_not_holding_item():
		return false
	
	return pickup_item_component.can_be_used_for_attack()

func player_in_vertical_range(player : CharacterBody2D) -> bool:
	var rotation_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.ROTATIONTRACKER)
	
	if not player.has_meta(rotation_meta_name):
		return false
	
	var player_rotation_tracker_component : RotationTrackerComponent = player.get_meta(rotation_meta_name) as RotationTrackerComponent
	
	var vertical_distance : float = abs(player_rotation_tracker_component.psuedo_vertical_coordinate - rotation_tracker_component.psuedo_vertical_coordinate)
	
	if vertical_distance <= vertical_fov:
		return true
	
	return false
