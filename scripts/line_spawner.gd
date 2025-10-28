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
	
	for ingredient : Item in items:
		var should_exist : int = randi_range(0, 1)
		if (!should_exist):
			continue
		var randomval : int = randi_range(ingredient.minorderrng, ingredient.maxorderrng)
		retdict[ingredient.name] = randomval
	# set a guaranteed item
	var guaranteeditem : Item = items[randi_range(0,len(items)-1)]
	retdict[guaranteeditem.name] = randi_range(guaranteeditem.minorderrng, guaranteeditem.maxorderrng)
	return Order.new(retdict)

func _on_timer_timeout() -> void:
	var orderno : int = len(GlobalState.orders.keys())+1
	var order : Order = generate_order()
	GlobalSignal.add_order.emit(orderno, order)
	pass # Replace with function body.
