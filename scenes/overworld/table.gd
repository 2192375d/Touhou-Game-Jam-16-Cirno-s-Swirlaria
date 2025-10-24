extends StaticBody2D

@onready var area : Area2D = get_node("Area2D")
@onready var hoversprite : Sprite2D = get_node("HoverSprite")

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node):
	if body is Player:
		hoversprite.visible = true
		GlobalSignal.display_tooltip.emit("Space to Interact", true)
		print("player entered")

func _on_body_exited(body: Node):
	if body is Player:
		hoversprite.visible = false
		GlobalSignal.display_tooltip.emit("", false)
		print("player exited")
