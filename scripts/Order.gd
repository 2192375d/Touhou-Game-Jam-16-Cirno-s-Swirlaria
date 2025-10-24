class_name Order extends Resource

@export var base : Array[String]
@export var ingredients : Array[String]

func _init(p_base : Array[String], p_ingredients : Array[String]):
	base = p_base
	ingredients = p_ingredients
