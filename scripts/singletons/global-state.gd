extends Node

# script to handle global state shared between scenes

static var score : int = 0
static var hp : int = 5

static var orders : Dictionary[int, Order] = {
	1 : Order.new({"Chocolate" : 10, "Vanilla" : 5, "Cherry" : 2}),
	2 : Order.new({"Vanilla" : 5, "Sprinkles" : 3, "Crisp" : 1}),
	3 : Order.new({"Strawberry" : 10, "Vanilla" : 5, "Crisp" : 2}),
	}
	

static var inventory : Dictionary[Item, int] = load("res://resources/Inventory.tres").items

#{
	#"Chocolate" : 20,
	#"Vanilla" : 20,
	#"Strawberry" : 20,
	#"Sprinkles" : 10,
	#"Cherry" : 10,
	#"Banana" : 10,
	#"Crisp" : 10,
#}
