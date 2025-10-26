extends Node

class_name MovementComponent

@export var actor: CollisionObject2D
@export var slow_speed: float
@export var fast_speed: float

var can_move = true

#func enable_move(status: bool) -> void:
	#if status:
		#

func handle_movement (move_intent: Vector2i) -> void:
	if (move_intent == Vector2i.ZERO):
		actor.velocity = Vector2.ZERO
		return

	var v: Vector2 = move_intent
	v = v.normalized()
	
	if can_move:
		if Input.is_action_pressed("ui_shift"):
			actor.velocity = v * slow_speed
		else:
			actor.velocity = v * fast_speed
	else:
		actor.velocity = Vector2.ZERO
