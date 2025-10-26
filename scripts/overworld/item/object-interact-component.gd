extends Node

class_name ObjectInteractComponent

@export var area: Area2D
@export var sprite : Sprite2D
@export var collectable : bool = false

@onready var inArea: bool = false

signal interacted()

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node):
	
	if body is Player:
		inArea = true
		if sprite:
			sprite.modulate = Color(10, 10, 10, 1)

func _on_body_exited(body: Node):
	if body is Player:
		inArea = false
		if sprite:
			sprite.modulate = Color(1, 1, 1, 1)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && inArea == true:
		interacted.emit()
		if collectable:
			GlobalState.score += 2
			GlobalSignal.score_update.emit()
		
