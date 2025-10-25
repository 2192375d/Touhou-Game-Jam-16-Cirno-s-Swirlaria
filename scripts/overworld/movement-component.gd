extends Node

class_name MovementComponent

@export var actor: CollisionObject2D
@export var speed: float

func handle_movement (move_intent: Vector2i) -> void:
	if (move_intent == Vector2i.ZERO):
		actor.velocity = Vector2.ZERO
		return
	
	var v: Vector2 = move_intent
	v = v.normalized()
	actor.velocity = v * speed
