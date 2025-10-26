class_name Order extends Resource

@export var ingredients : Dictionary[String, int]

func _init(p_ingredients : Dictionary[String, int]):
	ingredients = p_ingredients

func get_score(composition : Dictionary[String, int]) -> int:
	var points : int = 0
	for key in ingredients:
		points += min(composition[key], ingredients[key])
	return points
	

func check_fufilled(composition : Dictionary[String, int]) -> bool:
	for key in ingredients:
		if composition[key] < ingredients[key]:
			return false
	return true

func get_fufilled_list(composition : Dictionary[String, int]) -> Array[String]:
	var retArray : Array[String] = []
	for key in ingredients:
		if composition[key] >= ingredients[key]:
			retArray.append(key)
	return retArray
