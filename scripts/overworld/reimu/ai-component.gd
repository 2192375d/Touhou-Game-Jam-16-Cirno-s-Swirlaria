extends Node

class_name AIComponent

@export var ai_character: CharacterBody2D
@export var bullet_patterns: Array[Node]
@export var action_timer: Timer
@export var shot_timer: Timer #just initiate stuffs

@export var TIME_BETWEEN_ACTION_HIGH: float
@export var TIME_BETWEEN_ACTION_LOW: float


func _ready() -> void:
	action_timer.one_shot = true
	action_timer.autostart = false
	shot_timer.one_shot = true
	shot_timer.autostart = false
	
	action_timer.start(randf_range(TIME_BETWEEN_ACTION_LOW, TIME_BETWEEN_ACTION_HIGH))
	GlobalSignal.pattern_end.connect(_on_pattern_end)

func _on_actiontimer_timeout() -> void:
	var selected_pattern: Node = bullet_patterns[randi() % bullet_patterns.size()]
	selected_pattern.pattern_start()


func _on_pattern_end():
	action_timer.start(randf_range(TIME_BETWEEN_ACTION_LOW, TIME_BETWEEN_ACTION_HIGH))
