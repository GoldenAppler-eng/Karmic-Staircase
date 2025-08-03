extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area : Area2D) -> void:
	if not area is ToolTipActivationComponent:
		return
		
	(area as ToolTipActivationComponent).activate()
	
func _on_area_exited(area : Area2D) -> void:
	if not area is ToolTipActivationComponent:
		return

	(area as ToolTipActivationComponent).deactivate()
