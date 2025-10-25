extends Node2D

func _ready() -> void:
	randomize()

func _on_bulletzone_area_exited(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()
