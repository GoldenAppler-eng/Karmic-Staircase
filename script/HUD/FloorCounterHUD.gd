extends Label

@export var staircase_level_manager : StaircaseLevelManager

func _physics_process(delta: float) -> void:
	text = "Floor: " + str(staircase_level_manager.current_level + 1) + "/" + str(staircase_level_manager.number_of_levels)
