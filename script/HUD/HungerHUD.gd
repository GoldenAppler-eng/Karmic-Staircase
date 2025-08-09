extends Control

@export var player : Player

var player_stat_data : StatData

@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	var stat_meta_name : StringName = GlobalConstants.get_component_name(GlobalConstants.COMPONENT.STATDATA)
	
	var stat_data_component : StatDataComponent = player.get_meta(stat_meta_name)
	
	player_stat_data = stat_data_component.data
	
	animation_player.play("name_fade_out")

func _physics_process(delta: float) -> void:
	texture_progress_bar.value = player_stat_data.hunger
