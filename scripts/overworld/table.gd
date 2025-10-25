extends StaticBody2D

@onready var area : Area2D = get_node("Area2D")
@onready var hoversprite : Sprite2D = get_node("HoverSprite")

var general_text : RichTextLabel

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	general_text = 	GlobalText.create_text("Space to Interact", Vector2(5,20))
	add_child(general_text)

func _on_body_entered(body: Node):
	if body is Player:
		hoversprite.visible = true
		print("player entered")
		general_text.visible = true

func _on_body_exited(body: Node):
	if body is Player:
		hoversprite.visible = false
		print("player exited")
		general_text.visible = false
