extends Panel

@export var item: Item
@export var inventory: Inventory = load("res://resources/Inventory.tres")
@export var item_display: Sprite2D
@export var label: Label

func _ready() -> void:
	item_display.texture = item.texture
	label.text = str(inventory.items[item])
	GlobalSignal.inventory_update.connect(_on_inventory_update)

func _on_inventory_update() -> void:
	label.text = str(inventory.items[item])
