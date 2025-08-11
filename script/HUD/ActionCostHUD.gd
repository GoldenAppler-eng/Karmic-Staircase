extends SlidingTextBox

enum STAT_TYPE {HUNGER, DESPERATION}

@export var player : Player

func _ready() -> void:
	super()
	
	player.stat_data_component.desperation_changed.connect(_on_stats_changed.bind(STAT_TYPE.DESPERATION))
	player.stat_data_component.hunger_changed.connect(_on_stats_changed.bind(STAT_TYPE.HUNGER))

func _on_stats_changed(net_change : float, stat_type : STAT_TYPE) -> void:
	var value : int = abs(net_change)
	var sign : String = "+" if net_change >= 0 else "-" 
	
	match stat_type:
		STAT_TYPE.HUNGER:
			add_text_to_queue("[color=#e6a16c]"  + sign + str(value) + " Hunger")
		STAT_TYPE.DESPERATION:
			add_text_to_queue("[color=#d95763]" + sign + str(value) + " Desperation")
