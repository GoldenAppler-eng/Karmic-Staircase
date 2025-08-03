extends HSlider

@export_enum("Master", "Ambience", "Sfx") var bus_name : String = "Master"

func _on_value_changed(changed_value: float) -> void:
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_linear(bus_index, changed_value / 100.0)

func _on_visibility_changed() -> void:
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	value = AudioServer.get_bus_volume_linear(bus_index) * 100
