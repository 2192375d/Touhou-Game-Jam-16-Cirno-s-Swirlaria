extends Node

@onready var pause_menu = get_node("Pausemenu")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("menuescape"):
		print("PAUSED")
		get_tree().paused = true
		pause_menu.visible = true
