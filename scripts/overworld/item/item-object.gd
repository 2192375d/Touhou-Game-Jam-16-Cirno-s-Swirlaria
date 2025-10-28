extends Node2D

@onready var particles : CPUParticles2D = get_node("CPUParticles2D")

@export var object_interact_component: ObjectInteractComponent
@export var item: Item
@export var inventory: Inventory
@export var icon: Sprite2D

var iconshadow : Sprite2D

func _ready() -> void:
	inventory = load("res://resources/Inventory.tres")
	object_interact_component = $ObjectInteractComponent
	icon = $Sprite2D
	icon.texture = item.texture
	iconshadow = icon.duplicate()
	iconshadow.modulate = Color()
	iconshadow.position = icon.position + Vector2(2,2)
	iconshadow.z_index =  icon.z_index-1
	add_child(iconshadow)
	object_interact_component.interacted.connect(_on_interact)
	# Setup particle affects
	particles.emitting = true

func _process(delta: float) -> void:
	icon.rotate(0.01)
	iconshadow.rotate(0.01)


func _on_interact() -> void:
	if item.name == "Chocolate" || item.name == "Vanilla" || item.name == "Strawberry":
		inventory.items[item] += 10
	else:
		inventory.items[item] += 1
	GlobalSignal.inventory_update.emit()
	self.queue_free()
