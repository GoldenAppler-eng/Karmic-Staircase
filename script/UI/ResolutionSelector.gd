extends OptionButton

const RESOLUTIONS : Dictionary = {
	"960x540" : Vector2i(960, 540),
	"1280x720" : Vector2i(1280, 720),
	"1600x900" : Vector2i(1600, 900),
	"1920x1080" : Vector2i(1920, 1080),
	"2560x1440" : Vector2i(2560, 1440),
	"3840x2160" : Vector2i(3840, 2160)
}

func _ready() -> void:
	var index : int = 0
	for resolution in RESOLUTIONS.keys():
		add_item(resolution)
		set_item_metadata(index, RESOLUTIONS[resolution])
				
		#if RESOLUTIONS[resolution] == viewport.get_size_2d_override():
		#	select(index)
		
		index += 1

	var pm : PopupMenu = get_popup()
	
	for i in pm.item_count:
		pm.set_item_as_radio_checkable(i, false)

func _on_item_selected(index: int) -> void:
	var resolution : Vector2i = get_item_metadata(index)
		
	ProjectSettings.set_setting("display/window/size/window_width_override", resolution.x)
	ProjectSettings.set_setting("display/window/size/window_width_override", resolution.y)
