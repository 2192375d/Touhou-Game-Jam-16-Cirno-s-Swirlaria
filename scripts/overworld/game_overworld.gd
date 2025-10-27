extends Node2D

@onready var time_elapsed_timer: Timer = $"time-elapsed-timer"
@onready var time_label: Label = $timeLabel

func _ready() -> void:
	randomize()
	GlobalSignal.hp_update.connect(_on_hp_update)
	time_elapsed_timer.start(GlobalState.time)

func _on_bulletzone_area_exited(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()

func _on_hp_update() -> void:
	if GlobalState.hp <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _process(_delta: float) -> void:
	time_label.text = "time left: " + str(int(time_elapsed_timer.time_left))

func _on_timeelapsedtimer_timeout() -> void:
	if (GlobalState.score >= 10000):
		get_tree().change_scene_to_file("res://scenes/game_endpage.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		pass
		# game over scene
		# get_tree().change_scene_to_file("res://scenes/game_endpage.tscn")
