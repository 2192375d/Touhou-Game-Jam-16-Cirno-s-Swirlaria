extends CharacterBody2D

class_name Player

@onready var invincible_timer : Timer = get_node("InvincibilityTimer")

@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var inventory: Inventory
@export var spawn_point: Vector2 = Vector2.ZERO

func _ready() -> void:
	OverworldData.player = self
	position = spawn_point

func _process(_delta: float) -> void:
	var move_indent = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	movement_component.handle_movement(move_indent)
	animation_component.handle_animation(move_indent)
	move_and_slide()
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Bullet and invincible_timer.is_stopped():
		GlobalState.hp -= 1
		GlobalSignal.hp_update.emit()
		position = spawn_point
		print("you lost a HP! HP = ", GlobalState.hp)
		invincible_timer.start(1) # start for one second
