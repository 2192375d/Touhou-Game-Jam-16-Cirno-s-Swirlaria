extends Node2D

@onready var visitor : MarginContainer = get_node("Visitor")
@onready var vbox : VBoxContainer = get_node("Control/VBoxContainer")


static var allvisitors : Array[MarginContainer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# hydrate the list of orders first
	for a in GlobalState.orders.keys():
		add_order()
	GlobalSignal.add_order.connect(add_visitor, CONNECT_DEFERRED)
	GlobalSignal.remove_order.connect(remove_visitor, CONNECT_DEFERRED)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_visitor() -> MarginContainer:
	var newvisitor = visitor.duplicate()
	newvisitor.visible = true
	vbox.add_child(newvisitor)
	return newvisitor
	
func add_order() -> void:
	print("NEW VISITOR WAS ADDDED")
	var newvisitor = add_visitor()
	allvisitors.append(newvisitor)

func _on_add_order(orderno: int, order : Order) -> void:
	add_order()

func remove_visitor(orderno : int) -> void:
	print("removing visitor")
	if (len(allvisitors) > 0):
		allvisitors[0].queue_free()
		allvisitors.pop_front()
	
