extends SubViewport

var parent_viewport: Viewport

func _ready() -> void:
	parent_viewport = get_tree().root.get_viewport()
	parent_viewport.size_changed.connect(_parent_size_changed)

func _parent_size_changed():
	size = parent_viewport.size
