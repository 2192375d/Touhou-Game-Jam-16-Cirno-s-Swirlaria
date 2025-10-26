extends Node

@export var actor: CharacterBody2D
@export var shot_timer: Timer
@export var NUM_SHOT: int
@export var SHOT_SPEED: float
@export var SHOT_COOLDOWN: float

@onready var count: int = 0

@onready var my_turn: bool = false

const BULLET_SCENE: PackedScene = preload("res://scenes/overworld/bullet.tscn")
const BULLET_RESOURCE = preload("res://resources/bullet/arrow-head.tres")

func pattern_start():
	my_turn = true
	count = 0
	shot_timer.start(SHOT_COOLDOWN)
	print("pattern: 2 starts")

func _on_shottimer_timeout() -> void:
	if my_turn == false:
		return
	
	var bullet_node: Bullet
	
	var v: Vector2
	v = (OverworldData.player.global_position - actor.global_position).normalized()
	var dir = v.angle()
	
	for i in range (-1, 2):
		bullet_node = BULLET_SCENE.instantiate()
		bullet_node.global_position = actor.global_position
		
		bullet_node.bullet_resource = BULLET_RESOURCE
		bullet_node.set_bullet(dir + i * PI / 6, SHOT_SPEED)
		get_tree().current_scene.add_child.call_deferred(bullet_node)
	
	if count < NUM_SHOT:
		shot_timer.start(SHOT_COOLDOWN)
		count += 1
	else:
		GlobalSignal.pattern_end.emit()
		my_turn = false
