extends Node

class_name AnimationComponent
@export var anim: AnimatedSprite2D

enum Facing {UP, DOWN, LEFT, RIGHT} 
enum Locomotion {IDLE, WALK}

@onready var facing: Facing = Facing.DOWN
@onready var locomotion: Locomotion = Locomotion.IDLE

func handle_animation (move_intent: Vector2i) -> void:
	set_animation_enum(move_intent)
	anim.play(get_animation_string())

func get_animation_string () -> String:
	var animation_name: String
	animation_name = ""
	
	match locomotion:
		Locomotion.IDLE: animation_name += "idle_"
		Locomotion.WALK: animation_name += "walk_"
	match facing:
		Facing.UP: animation_name += "up"
		Facing.DOWN: animation_name += "down"
		Facing.LEFT: animation_name += "left"
		Facing.RIGHT: animation_name += "right"
	
	return animation_name

func set_animation_enum (move_intent: Vector2i) -> void:
	if move_intent == Vector2i.ZERO:
		locomotion = Locomotion.IDLE
		return
	
	locomotion = Locomotion.WALK
	
	if move_intent[0] < 0:
		facing = Facing.LEFT
		return
	
	if move_intent[0] > 0:
		facing = Facing.RIGHT
		return
	
	if move_intent[1] < 0:
		facing = Facing.UP
		return
	
	if move_intent[1] > 0:
		facing = Facing.DOWN
		return
