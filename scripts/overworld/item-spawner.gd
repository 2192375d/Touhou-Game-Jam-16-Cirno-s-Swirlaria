extends Node

@export var spawnTimer: Timer
@export var items: Array[Item]
var numItem: int

# 12 x 10
func _ready() -> void:
	spawnTimer.one_shot = true
	spawnTimer.start(3)
	
	numItem = 0

func _on_timer_timeout() -> void:
	var item_position: Vector2i
	item_position = Vector2i((randi() % 12 + 17) * 32, (randi() % 10 + 3) * 32)
	
