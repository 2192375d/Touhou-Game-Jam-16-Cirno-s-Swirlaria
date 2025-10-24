extends Node2D

@export var object_interact_component: ObjectInteractComponent
@export var item: Item
@export var inventory: Inventory
@export var icon: Sprite2D

func _ready() -> void:
	inventory = load("res://inventory/Inventory.tres")
	object_interact_component = $ObjectInteractComponent
	icon = $Sprite2D
	
	icon.texture = item.texture
	object_interact_component.interacted.connect(_on_interact)

func _on_interact() -> void:
	inventory.items[item] += 1
	GlobalSignal.inventory_update.emit()
	self.queue_free()
