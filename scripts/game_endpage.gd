extends Control

@export var score: Label

@onready var scenes : Array[Sprite2D] = [
	get_node("Scene1"),
	get_node("Scene2"),
	get_node("Scene3")
]
var index : int = 0

func _ready():
	score.text = str(GlobalState.score)

func display_image() -> void:
	print("index is" + str(index))
	if (index >= 1):
		scenes[index-1].visible = false
	if (index == 3):
		get_tree().change_scene_to_file("res://scenes/game_titlepage.tscn")	
	else:
		# display the image
		scenes[index].visible = true
		scenes[index].z_index = index
	
func _on_button_pressed() -> void:
	display_image()
	index += 1
