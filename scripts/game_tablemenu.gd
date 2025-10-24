extends Node2D

@onready var conesprite = get_node("ConeSprite")

@onready var sprinklessprite = get_node("Sprinkles")
@onready var cherrysprite = get_node("Cherry")
@onready var cherryspriteraw = get_node("Cherry")

@onready var creamraw = get_node("CreamRaw")
@onready var nozzlebutton = get_node("Nozzle")

var globalCone : Sprite2D = null
var mousepos : Vector2
var currentTopping : Button = null
var clickingNozzle : bool
var creamqueue : Array[RigidBody2D] = []

func _ready():
	conesprite.get_node("StaticBody2D").get_node("CollisionPolygon2D").disabled = true
	creamraw.get_node("CollisionPolygon2D").disabled = true
	print("Hello World")

func _input(event):
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mousepos = get_viewport().get_mouse_position()
	if (currentTopping != null):
		currentTopping.position.x = mousepos.x - currentTopping.size.x/2
		currentTopping.position.y = mousepos.y - currentTopping.size.y/2
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
	
func _on_cherry_button_down() -> void:
	print("down topping")
	currentTopping = cherrysprite.duplicate()
	currentTopping.visible = true
	add_child(currentTopping)

func _on_cherry_button_up() -> void:
	print("up topping")
	currentTopping = null

func _on_timer_timeout() -> void:
	print("timeout")
	if clickingNozzle:
		var newcream = creamraw.duplicate()
		creamqueue.append(newcream)
		newcream.visible = true
		newcream.freeze = false
		newcream.get_node("CollisionPolygon2D").disabled = false
		newcream.gravity_scale = 1.0
		add_child(newcream)
	# currentTopping = cherrysprite.duplicate()
	# currentTopping.visible = true
	# add_child(currentTopping)
	# create a new cream object
	pass # Replace with function body.
