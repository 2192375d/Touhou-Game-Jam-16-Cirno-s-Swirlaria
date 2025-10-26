extends Node

@export var actor: CharacterBody2D
@export var shot_timer: Timer
@export var NUM_SHOT: int
@export var SHOT_SPEED: float
@export var SHOT_COOLDOWN: float

@onready var my_turn: bool = false

@onready var count: int = 0

const BULLET_SCENE: PackedScene = preload("res://scenes/overworld/bullet.tscn")
const BULLET_RESOURCE = preload("res://resources/bullet/arrow-head.tres")

func pattern_start():
	my_turn = true
	count = 0
	shot_timer.start(SHOT_COOLDOWN)

func _on_shottimer_timeout() -> void:
	if my_turn == false:
		return
	
	var bullet_node: Bullet
	
	for i in range (-1, 2):
		bullet_node = BULLET_SCENE.instantiate()
		bullet_node.global_position = actor.global_position
		
		bullet_node.bullet_resource = BULLET_RESOURCE
		bullet_node.set_bullet(-(PI + count * PI/16 + i * PI/8), SHOT_SPEED)
		get_tree().current_scene.add_child.call_deferred(bullet_node)
	
	if count < NUM_SHOT:
		shot_timer.start(SHOT_COOLDOWN)
		count += 1
	else:
		GlobalSignal.pattern_end.emit()
		my_turn = false
