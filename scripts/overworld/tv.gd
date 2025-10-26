extends Node2D

@onready var hearts = get_node("Hearts/TileMap")
@onready var hboxhandle = get_node("Control/HBoxContainer")

var numhearts : int = GlobalState.hp
var score : int = GlobalState.score

var scoremappings : Dictionary[int, TileMap]

func display_hearts():
	hearts.clear_layer(0)
	for i in range(0,numhearts):
		hearts.set_cell(0, Vector2i(i, 0), 0, Vector2i(0, 0))

func display_score():
	var curr = 1000000
	while curr > 0:
		var rem : int = (score / curr) % 10
		print(rem)
		scoremappings[curr].clear_layer(0)
		if (rem == 0):
			scoremappings[curr].set_cell(0, Vector2i(0, 0), 0, Vector2i(9, 44))
		else:	
			scoremappings[curr].set_cell(0, Vector2i(0, 0), 0, Vector2i(rem-1, 44))
		curr /= 10
	
func _ready() -> void:
	scoremappings = {
	1000000 : hboxhandle.get_node("Score1000000/Sprite2D/TileMap"),
	100000 : hboxhandle.get_node("Score100000/Sprite2D/TileMap"),
	10000 : hboxhandle.get_node("Score10000/Sprite2D/TileMap"),
	1000 : hboxhandle.get_node("Score1000/Sprite2D/TileMap"),
	100 : hboxhandle.get_node("Score100/Sprite2D/TileMap"),
	10 : hboxhandle.get_node("Score10/Sprite2D/TileMap"),
	1 : hboxhandle.get_node("Score1/Sprite2D/TileMap")
	}	
	display_hearts()
	display_score()
	GlobalSignal.score_update.connect(_on_score_update)

func _on_score_update() -> void:
	numhearts = GlobalState.hp
	score = GlobalState.score
	display_hearts()
	display_score()
