extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_order() -> Order:
	var retdict : Dictionary[String, int]
	var items = load("res://resources/Inventory.tres").items.keys()
	var index = 0
	for ingredient : Item in items:
		var ranLarge : int = randi_range(15, 25)
		var ranSmall : int = randi_range(0, 10)
		# ice cream base only
		if index < 3 and ranLarge != 0:
			retdict[ingredient.name] = ranLarge
		elif index > 3 and ranSmall != 0:
			retdict[ingredient.name] = ranSmall
		index += 1
	return Order.new(retdict)

func _on_timer_timeout() -> void:
	var orderno : int = len(GlobalState.orders.keys())+1
	var order : Order = generate_order()
	GlobalSignal.add_order.emit(orderno, order)
	pass # Replace with function body.
