extends Node

signal inventory_update()
signal pattern_end()
signal score_update()  # it gets its value from global-state
signal hp_update()  # it gets its value from global-state

func _ready() -> void:
	inventory_update.connect(_on_inventory_update)
	
func _on_inventory_update() -> void:
	GlobalState.inventory = load("res://resources/Inventory.tres").items 
	
