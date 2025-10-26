extends Node

@export var actor: CharacterBody2D
@export var shot_timer: Timer
@export var NUM_SHOT: int
@export var SHOT_SPEED: float
@export var SHOT_COOLDOWN: float

@onready var switch: int = 0
@onready var count: int = 0

@onready var my_turn: bool = false

func pattern_start():
	my_turn = true
	count = 0
	switch = 0
	shot_timer.start(SHOT_COOLDOWN)

func _on_shottimer_timeout() -> void:
	if my_turn == false:
		return
	
	var bullet_scene = preload("res://scenes/overworld/bullet.tscn")
	var bullet_node: Bullet
	
	for i in range (-2, 3):
		bullet_node = bullet_scene.instantiate()
		bullet_node.position = actor.position
		
		bullet_node.bullet_resource = load("res://resources/bullet/amulet.tres")
		bullet_node.set_bullet(PI / 2 + i * PI / 4 + switch * PI / 8, SHOT_SPEED)
		get_tree().current_scene.add_child.call_deferred(bullet_node)
		
	if switch == 0:
		switch = 1
	else:
		switch = 0
	
	if count < NUM_SHOT:
		shot_timer.start(SHOT_COOLDOWN)
		count += 1
	else:
		GlobalSignal.pattern_end.emit()
		my_turn = false
