class_name PlayerVisionComponent
extends Area2D

@export var fov : float = 0


var ignore_player : CharacterBody2D
var movement_component : MovementComponent

var players_in_area : Array[CharacterBody2D]

func init(p_ignore_player : CharacterBody2D, p_movement_component : MovementComponent) -> void:
	ignore_player = p_ignore_player
	movement_component = p_movement_component
	
	body_entered.connect(_on_player_entered_area)
	body_exited.connect(_on_player_exited_area)

func get_number_of_seen_player() -> int:
	var num_of_players_seen : int = 0
	
	var forward : Vector2 = Vector2(10, 0) if not movement_component.last_facing_right else Vector2(-10, 0)
	
	for player in players_in_area:
		var to_player : Vector2 = player.global_position - global_position
		var dot : float = forward.dot(to_player)
		
		if dot <= fov:
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

func get_closest_player() -> CharacterBody2D:
	var min_distance : float = 99999
	var closest_player : CharacterBody2D = null
		
	var forward : Vector2 = Vector2(10, 0) if not movement_component.last_facing_right else Vector2(-10, 0)
	
	for player in players_in_area:
		var to_player : Vector2 = player.global_position - global_position
		var dot : float = forward.dot(to_player)
		
		if dot > fov:
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
