extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _on_water_drip_timer_timeout() -> void:
	audio_stream_player.play()
	gpu_particles_2d.restart()
