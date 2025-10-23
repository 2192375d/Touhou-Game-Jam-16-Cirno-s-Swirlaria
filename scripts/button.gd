extends Button

var simultaneous_scene = preload("res://scenes/game_overworld.tscn").instantiate()

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_overworld.tscn")
	pass # Replace with function body
