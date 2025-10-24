extends CharacterBody2D

class_name Player

@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent

@export var inventory: Inventory

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	var move_indent = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	movement_component.handle_movement(move_indent)
	animation_component.handle_animation(move_indent)
	move_and_slide()
