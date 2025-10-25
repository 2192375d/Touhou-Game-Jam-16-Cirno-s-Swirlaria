extends Node2D

@onready var hearts = get_node("Hearts").get_node("TileMap")
var numhearts : int = 5

func display_hearts():
	hearts.clear_layer(0)
	for i in range(0,numhearts):
		hearts.set_cell(0, Vector2i(i, 0), 0, Vector2i(0, 0))
		
	#for i in range(5-numhearts):
		#print(i)
		#hearts.erase_cell(0, Vector2i(i, 0))

func _ready() -> void:
	display_hearts()
