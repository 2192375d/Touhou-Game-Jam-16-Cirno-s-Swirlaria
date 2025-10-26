extends Node2D

func _ready() -> void:
	randomize()
	GlobalSignal.hp_update.connect(_on_hp_update)

func _on_bulletzone_area_exited(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()

func _on_hp_update() -> void:
	if GlobalState.hp <= 0:
		pass
