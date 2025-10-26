extends Control

@export var score: Label

func _ready():
	score.text = str(GlobalState.score)
