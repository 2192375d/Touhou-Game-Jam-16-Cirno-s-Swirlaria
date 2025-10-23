extends Node2D

@onready var conesprite = get_node("ConeSprite")
var globalCone : Node2D = null
var mousepos : Vector2

func _ready():
	print("Hello World")

func _input(event):
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mousepos = get_viewport().get_mouse_position()
	if (globalCone != null):
		print(globalCone.position)
		globalCone.position.x = mousepos.x
	
	pass

func _on_cone_button_down() -> void:
	print("hello")
	# generate new cone
	globalCone = conesprite.duplicate()
	globalCone.visible = true
	add_child(globalCone)
	
	
	

	
