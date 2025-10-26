extends CharacterBody2D

class_name Player

@onready var invincible_timer : Timer = get_node("InvincibilityTimer")

@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var inventory: Inventory
@export var spawn_point: Vector2 = Vector2.ZERO
@export var hitbox_dot: Sprite2D

func _ready() -> void:
	OverworldData.player = self
	position = spawn_point
	hitbox_dot.hide()

func _process(_delta: float) -> void:
	var move_indent = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	movement_component.handle_movement(move_indent)
	animation_component.handle_animation(move_indent)
	
	if Input.is_action_pressed("ui_shift"):
		hitbox_dot.show()
	if Input.is_action_just_released("ui_shift"):
		hitbox_dot.hide()
	
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Bullet and invincible_timer.is_stopped():
		GlobalState.hp -= 1
		GlobalSignal.hp_update.emit()
		invincible_timer.start(1) # start for one second
		movement_component.can_move = false
		
		if GlobalState.hp != 0:
			for i in range(3):
				self.hide()
				await get_tree().create_timer(0.1).timeout
				self.show()
				await get_tree().create_timer(0.1).timeout
		position = spawn_point
		movement_component.can_move = true
		print("you lost a HP! HP = ", GlobalState.hp)
