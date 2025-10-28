extends Node2D

@onready var titlescreenstates : Array[Control] = [
	get_node("Scene1"),
	get_node("Scene2"),
	get_node("Scene3"),
	get_node("Scene4"),
	get_node("Scene5"),
	get_node("Scene6"),
	get_node("Scene7"),
	get_node("Scene8"),
]

var index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	_on_button_pressed()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_image() -> void:
	print("index is" + str(index))
	if (index >= 1):
		titlescreenstates[index-1].visible = false
	if (index == 8):
		get_tree().change_scene_to_file("res://scenes/overworld/game_overworld.tscn")	
	else:
		# display the image
		titlescreenstates[index].visible = true
		titlescreenstates[index].z_index = index
	
func _on_button_pressed() -> void:
	display_image()
	index += 1
