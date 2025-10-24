extends Node2D

@onready var conesprite = get_node("ConeSprite")

@onready var sprinklesspriteraw = get_node("SprinklesRaw")
@onready var cherryspriteraw = get_node("CherryRaw")

@onready var creamraw = get_node("CreamRaw")
@onready var nozzlebutton = get_node("Nozzle")

@export var orders = []


var globalCone : Sprite2D = null
var mousepos : Vector2
var currentTopping : RigidBody2D = null
var clickingNozzle : bool
var creamqueue : Array[RigidBody2D] = []
var toppingqueue : Array[RigidBody2D] = []

func _ready():
	conesprite.get_node("StaticBody2D").get_node("CollisionPolygon2D").disabled = true
	creamraw.get_node("CollisionPolygon2D").disabled = true
	cherryspriteraw.get_node("CollisionShape2D").disabled = true
	sprinklesspriteraw.get_node("CollisionShape2D").disabled = true
	print("Hello World")

func _input(event):
	if event.is_action_pressed("mousedown"):
		pass
		
	if event.is_action_released("mousedown"):
		if (currentTopping != null):
			currentTopping.freeze = false;
			currentTopping.linear_velocity = Vector2(0,0)
			currentTopping.angular_velocity = 0
			currentTopping.get_node("CollisionShape2D").disabled = false
			currentTopping = null;
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mousepos = get_viewport().get_mouse_position()
	if (currentTopping != null):
		print(currentTopping.position)
		currentTopping.position.x = mousepos.x - 12
		currentTopping.position.y = mousepos.y - 12
	elif (clickingNozzle):
		nozzlebutton.position.x = mousepos.x - nozzlebutton.size.x/2
		creamraw.position.x = mousepos.x
	

func _on_cone_button_down() -> void:
	# check if existing cone
	if (globalCone != null):
		globalCone.queue_free()
	# generate new cone
	globalCone = conesprite.duplicate()
	globalCone.get_node("StaticBody2D").get_node("CollisionPolygon2D").disabled = false
	globalCone.visible = true
	add_child(globalCone)

func _on_nozzle_button_down() -> void:
	clickingNozzle = true
func _on_nozzle_button_up() -> void:
	clickingNozzle = false	
	
func _on_sprinkles_button_down() -> void:
	currentTopping = sprinklesspriteraw.duplicate()
	toppingqueue.append(currentTopping)
	currentTopping.visible = true
	currentTopping.freeze = true
	currentTopping.get_node("CollisionShape2D").disabled = true
	add_child(currentTopping)
	
func _on_cherry_button_down() -> void:
	currentTopping = cherryspriteraw.duplicate()
	toppingqueue.append(currentTopping)
	currentTopping.visible = true
	currentTopping.freeze = true
	currentTopping.get_node("CollisionShape2D").disabled = true
	add_child(currentTopping)
	
func _on_timer_timeout() -> void:
	if clickingNozzle:
		var newcream = creamraw.duplicate()
		creamqueue.append(newcream)
		newcream.visible = true
		newcream.freeze = false
		newcream.get_node("CollisionPolygon2D").disabled = false
		newcream.gravity_scale = 1.0
		add_child(newcream)
	
func _on_chocolate_pressed() -> void:
	creamraw.get_node("Polygon2D").color = Color(0.778, 0.5, 0.351, 1.0)

func _on_vanilla_pressed() -> void:
	creamraw.get_node("Polygon2D").color = Color(1.0, 1.0, 1.0, 1.0)

func _on_strawberry_pressed() -> void:
	creamraw.get_node("Polygon2D").color = Color(0.977, 0.63, 0.761, 1.0)

func _on_clear_entities_pressed() -> void:
	for creamitem in creamqueue:
		if (is_instance_valid(creamitem)):
			creamitem.queue_free()
	for toppingitem in toppingqueue:
		if (is_instance_valid(toppingitem)):
			toppingitem.queue_free()
	creamqueue.clear()
	toppingqueue.clear()
