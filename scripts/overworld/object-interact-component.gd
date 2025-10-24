extends Node

class_name ObjectInteractComponent

@export var area: Area2D
@onready var inArea: bool = false
signal interacted()

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node):
	if body is Player:
		inArea = true
		#print("player entered")

func _on_body_exited(body: Node):
	if body is Player:
		inArea = false
		#print("player exited")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && inArea == true:
		interacted.emit()
