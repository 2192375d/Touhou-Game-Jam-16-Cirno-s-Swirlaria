extends Node2D

@onready var particles : CPUParticles2D = get_node("CPUParticles2D")

@export var object_interact_component: ObjectInteractComponent
@export var item: Item
@export var inventory: Inventory
@export var icon: Sprite2D

func _ready() -> void:
	inventory = load("res://resources/Inventory.tres")
	object_interact_component = $ObjectInteractComponent
	icon = $Sprite2D
	icon.texture = item.texture
	object_interact_component.interacted.connect(_on_interact)
	# Setup particle affects
	particles.emitting = true
	

func _on_interact() -> void:
	if item.name == "Chocolate" || item.name == "Vanilla" || item.name == "Strawberry":
		inventory.items[item] += 20
	else:
		inventory.items[item] += 1
	GlobalSignal.inventory_update.emit()
	self.queue_free()
