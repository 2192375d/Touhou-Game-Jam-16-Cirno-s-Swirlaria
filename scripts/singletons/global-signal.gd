extends Node

signal inventory_update()
signal pattern_end()
signal score_update()  # it gets its value from global-state
signal hp_update()  # it gets its value from global-state
signal add_order(orderno : int, order : Order)  
signal remove_order(orderno : int)

func _ready() -> void:
	add_order.connect(_on_add_order)
	remove_order.connect(_on_remove_order)
	

func _on_add_order(orderno : int, order : Order) -> void:
	GlobalState.orders[orderno] = order

func _on_remove_order(orderno : int) -> void:
	GlobalState.orders.erase(orderno)
