extends Node2D

@onready var visitor : MarginContainer = get_node("Visitor")
@onready var vbox : VBoxContainer = get_node("Control/VBoxContainer")
@export var order_popout: Panel
@export var popout_timer: Timer

static var allvisitors : Array[MarginContainer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	order_popout.hide() # by lumiere
	popout_timer.autostart = false # by lumiere
	popout_timer.one_shot = true # by lumiere
	
	print("HELLO I AM STARTED")
	# hydrate the list of orders first
	for a in GlobalState.orders.keys():
		add_order()
	# Make sure the connection happens
	call_deferred("_connect_signals")

func _connect_signals() -> void:
	if not GlobalSignal.add_order.is_connected(_on_add_order):
		GlobalSignal.add_order.connect(_on_add_order)
	if not GlobalSignal.add_order.is_connected(remove_visitor):
		GlobalSignal.remove_order.connect(remove_visitor)
	print("Signal connected in SecondFile") # Debug line

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_visitor() -> MarginContainer:
	order_popout.show() # by lumiere
	popout_timer.start(3.0)
	
	var newvisitor = visitor.duplicate()
	newvisitor.visible = true
	vbox.add_child(newvisitor)
	return newvisitor

func add_order() -> void:
	var newvisitor = add_visitor()
	newvisitor.get_node("TileMapLayer").set_cell(Vector2i(0,0),0,Vector2i(randi_range(0,5),0))
	allvisitors.append(newvisitor)

func _on_add_order(orderno: int, order : Order) -> void:
	add_order()

func remove_visitor(orderno : int) -> void:
	print("removing visitor")
	if (len(allvisitors) > 0):
		allvisitors[0].queue_free()
		allvisitors.pop_front()
	

func _on_popout_timer_timeout() -> void:
	order_popout.hide()
