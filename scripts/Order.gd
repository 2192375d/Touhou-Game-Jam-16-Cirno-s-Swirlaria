class_name Order extends Resource

@export var ingredients : Dictionary[String, int]

func _init(p_ingredients : Dictionary[String, int]):
	ingredients = p_ingredients

func check_fufilled(composition : Dictionary[String, int]) -> bool:
	for key in ingredients:
		if composition[key] < ingredients[key]:
			return false
	return true
