extends Node

@export var spawnTimer: Timer
@export var items: Array[Item]
@export var MAX_NUM_ITEM: int
var numItem: int

# 12 x 10
func _ready() -> void:
	
	spawnTimer.one_shot = true
	spawnTimer.start(0)
	GlobalSignal.inventory_update.connect(_on_inventory_update)
	
	numItem = 0

func _on_timer_timeout() -> void:
	var item_position: Vector2i
	
	var val1: int = randi() % 10
	var val2: int = randi() % 10
	
	item_position = Vector2i((val1 + 17) * 64, (val2 + 3) * 64)
	
	var item_scene = preload("res://scenes/overworld/item_object.tscn")
	var item_node = item_scene.instantiate()
	item_node.position = item_position
	item_node.item = items[randi() % 3]
	get_tree().current_scene.add_child.call_deferred(item_node)
	numItem += 1
	
	if numItem < MAX_NUM_ITEM:
		spawnTimer.start(randf_range(2, 3))

func _on_inventory_update():
	numItem -= 1
	spawnTimer.start(randf_range(2, 3))
