extends Node

class_name ItemObjectComponent

@export var object_interact_component: ObjectInteractComponent
@export var item: Item
@export var inventory: Inventory

func _ready() -> void:
	object_interact_component.interacted.connect(self.interact)

func interact() -> void:
	inventory.items[item] += 1
	print("here!")
