extends Node2D

@onready var conesprite = get_node("ConeSprite")
@onready var sprinklesspriteraw = get_node("SprinklesRaw")
@onready var cherryspriteraw = get_node("CherryRaw")
@onready var bananaraw = get_node("BananaRaw")
@onready var crispraw = get_node("CrispRaw")
@onready var creamraw = get_node("CreamRaw")
@onready var nozzlebutton = get_node("Nozzle")
@onready var vboxcontainer = get_node("Control/ScrollContainer/VBoxContainer")
@onready var ordertemplate = get_node("Control/ScrollContainer/VBoxContainer/Order")
@onready var orderingredienttemplate = get_node("Control/ScrollContainer/VBoxContainer/Order/HBoxContainer")
@onready var flavortext = get_node("Control3/CurrentFlavor/Flavor")
@onready var inventorycontainer = get_node("Control2/InventoryContainer")
@onready var ingredientcontainertemplate = get_node("Control2/InventoryContainer/IngredientContainer")
@onready var cursorup = load("res://assets/cursorup.png")
@onready var cursordown = load("res://assets/cursordown.png")

var orders : Dictionary[int, Order] = GlobalState.orders


# const
const toppingpositions = {
	"Cherry" : [Vector2i(0,0), Vector2i(0,1), Vector2i(1,0), Vector2i(1,1)],
	"Sprinkles" : [Vector2i(2,0), Vector2i(3,0), Vector2i(2,1), Vector2i(3,1), Vector2i(2,2), Vector2i(3,2), Vector2i(2,3), Vector2i(3,3)],
	"Banana" : [Vector2i(0,2), Vector2i(0,3), Vector2i(0,4)],
	"Crisp" : [Vector2i(1,2), Vector2i(1,3)],
}

# bss
var globalCone : Sprite2D = null
var mousepos : Vector2
var currentTopping : RigidBody2D = null
var clickingNozzle : bool
var creamqueue : Array[RigidBody2D] = []
var toppingqueue : Array[RigidBody2D] = []
var currentcomposition : Dictionary[String, int] 
var currentFlavor : String = "Vanilla"
var inventoryhandles : Dictionary[String, PanelContainer]
var orderhandles : Dictionary # Dictionary[int, Dictionary[String, Container]]
var inventory : Dictionary[String, int] 


func reset_currentcomposition() -> void:
	# return the inventoru back to original
	update_inventory_from_global_state()
	currentcomposition= {
	"Chocolate" : 0,
	"Vanilla" : 0,
	"Strawberry" : 0,
	"Sprinkles" : 0,
	"Cherry" : 0,
	"Banana" : 0,
	"Crisp" : 0,}

func setup_orders():
	for key in orders:
		var order = orders[key]
		var newordercomponent : VBoxContainer = ordertemplate.duplicate()
		newordercomponent.visible = true
		orderhandles[key] = {}
		orderhandles[key]["Origin"] = newordercomponent
		# iterate through the items within order
		for k : String in orders[key].ingredients:
			var newingredientcomponent : HBoxContainer = orderingredienttemplate.duplicate()
			orderhandles[key][k] = newingredientcomponent.get_node("CheckBox")
			newingredientcomponent.visible = true
			newingredientcomponent.get_node("Ingredient").text = k
			newingredientcomponent.get_node("Amount").text = str(orders[key].ingredients[k])
			newordercomponent.add_child(newingredientcomponent)
		newordercomponent.get_node("OrderNumberPanel").get_node("OrderNumber").text = "Order #" + str(key)
		newordercomponent.move_child(newordercomponent.get_node("Button"), newordercomponent.get_child_count() -1)
		newordercomponent.ordernumber = key
		vboxcontainer.add_child(newordercomponent)
	
	
func setup_inventory_display() -> void:
	for key in inventory:
		var newingredientcomponent = ingredientcontainertemplate.duplicate()
		newingredientcomponent.get_node("HBoxContainer").get_node("Ingredient").text = key
		newingredientcomponent.get_node("HBoxContainer").get_node("Amount").text = str(inventory[key])
		newingredientcomponent.visible = true
		inventorycontainer.add_child(newingredientcomponent)
		# save for later use
		inventoryhandles[key] = newingredientcomponent

func update_order_status() -> void:
	for key : int in orders:
		for k in orders[key].get_fufilled_list(currentcomposition):
			orderhandles[key][k].button_pressed = true

func clear_button_checks() -> void:
	for key : int in orderhandles:
		for k : String in orderhandles[key]:
			if orderhandles[key][k] is CheckBox:
				orderhandles[key][k].button_pressed = false

func update_inventory(key : String, change : int) -> void:
	if (key in inventory):
		inventory[key] -= change
		currentcomposition[key] += change
		
	for k in inventory:
		var newingredientcomponent = inventoryhandles[k]
		newingredientcomponent.get_node("HBoxContainer").get_node("Ingredient").text = k
		newingredientcomponent.get_node("HBoxContainer").get_node("Amount").text = str(inventory[k])
	update_order_status()
	# check to see if any checkmarks are good

func update_inventory_from_global_state() -> void:
	var globalinventory : Dictionary[Item, int] = load("res://resources/Inventory.tres").items
	for item : Item in globalinventory:
		inventory[item.name] = globalinventory[item]
	
func _ready():
	#creamraw.notfirst = false
	update_inventory_from_global_state()
	conesprite.get_node("StaticBody2D").get_node("CollisionPolygon2D").disabled = true
	creamraw.get_node("CollisionPolygon2D").disabled = true
	cherryspriteraw.get_node("CollisionShape2D").disabled = true
	sprinklesspriteraw.get_node("CollisionShape2D").disabled = true
	reset_currentcomposition()
	setup_orders()
	setup_inventory_display()	
	Input.set_custom_mouse_cursor(cursorup)
	

func _on_order_orderfufilled(ordernumber : int) -> void:
	#if orders[ordernumber].check_fufilled(currentcomposition):
	# modify global score depending on how close current composition is
	if (orders[ordernumber].check_fufilled(currentcomposition)):
		print("PLUS ONE LIFE")
	GlobalState.hp = min(GlobalState.hp+2, 5)
	GlobalSignal.hp_update.emit()
	print("SCORE GOTTEN FROM THIS IS:" + str(orders[ordernumber].get_score(currentcomposition)))
	GlobalState.score += orders[ordernumber].get_score(currentcomposition)
	GlobalSignal.score_update.emit()
	# change inventory
	var globalinventory : Dictionary[Item, int] = load("res://resources/Inventory.tres").items
	for key : Item in globalinventory:
		if key.name in currentcomposition:
			globalinventory[key] -= currentcomposition[key.name]
	print("Global State Updated")
	# remove the order
	GlobalSignal.remove_order.emit(ordernumber)
	# modify local variables
	orders.erase(ordernumber)
	orderhandles[ordernumber]["Origin"].queue_free()
	orderhandles.erase(ordernumber)
	reset_state()
	
func _input(event):
	if event.is_action_pressed("menuescape"):
		_on_return_pressed()

	if event.is_action_pressed("mousedown"):
		Input.set_custom_mouse_cursor(cursordown)
		pass
		
	if event.is_action_released("mousedown"):
		Input.set_custom_mouse_cursor(cursorup)
		if (currentTopping != null):
			currentTopping.freeze = false;
			currentTopping.linear_velocity = Vector2(0,0)
			currentTopping.angular_velocity = 0
			currentTopping.get_node("CollisionShape2D").disabled = false
			currentTopping = null;
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mousepos = get_viewport().get_mouse_position()
	#cursor.position = mousepos - Vector2(12,12)
	if (currentTopping != null):
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

func add_topping(toppingname : String) -> void:
	if (not toppingname in inventory) or inventory[toppingname] <= 0:
		return
	update_inventory(toppingname, 1)
	match toppingname:
		"Sprinkles":
			currentTopping = sprinklesspriteraw.duplicate()
		"Cherry":
			currentTopping = cherryspriteraw.duplicate()
		"Banana":
			currentTopping = bananaraw.duplicate()
		"Crisp":
			currentTopping = crispraw.duplicate()
	var tilemap : TileMapLayer = currentTopping.get_node("TileMapLayer") 
	var randompos : Vector2i = toppingpositions[toppingname].pick_random()
	print(randompos)
	tilemap.set_cell(Vector2i(0,0),0,randompos)
	toppingqueue.append(currentTopping)
	currentTopping.visible = true
	currentTopping.freeze = true
	currentTopping.get_node("CollisionShape2D").disabled = true
	add_child(currentTopping)
	
	
func _on_sprinkles_button_down() -> void:
	add_topping("Sprinkles")
	
func _on_cherry_button_down() -> void:
	add_topping("Cherry")
	
func _on_banana_button_down() -> void:
	add_topping("Banana")


func _on_crisp_button_down() -> void:
	add_topping("Crisp")

	
func _on_timer_timeout() -> void:
	if clickingNozzle and inventory[currentFlavor] > 0:
		update_inventory(currentFlavor, 1)
		var newcream = creamraw.duplicate()
		creamqueue.append(newcream)
		newcream.visible = true
		newcream.freeze = false
		newcream.get_node("CollisionPolygon2D").disabled = false
		newcream.gravity_scale = 1.0
		add_child(newcream)
	
func set_flavor(flavor : String):
	var targetcolor : Color
	match flavor:
		"Chocolate":
			targetcolor = Color(0.778, 0.5, 0.351, 1.0)
		"Vanilla":
			targetcolor = Color(1.0, 1.0, 1.0, 1.0)
		"Strawberry":
			targetcolor = Color(0.977, 0.63, 0.761, 1.0)
	creamraw.get_node("Sprite2D").modulate = targetcolor
	flavortext.add_theme_color_override("default_color", targetcolor)
	currentFlavor = flavor
	flavortext.text = flavor
	
func _on_chocolate_pressed() -> void:
	set_flavor("Chocolate")
	
func _on_vanilla_pressed() -> void:
	set_flavor("Vanilla")

func _on_strawberry_pressed() -> void:
	set_flavor("Strawberry")
	
func reset_state() -> void:
	reset_currentcomposition()
	clear_entities()
	clear_button_checks()
	update_inventory("Strawberry", 0)

func clear_entities() -> void:
	if (globalCone != null):
		globalCone.queue_free()
	for creamitem in creamqueue:
		if (is_instance_valid(creamitem)):
			creamitem.queue_free()
	for toppingitem in toppingqueue:
		if (is_instance_valid(toppingitem)):
			toppingitem.queue_free()
	creamqueue.clear()
	toppingqueue.clear()
	
func _on_clear_entities_pressed() -> void:
	reset_state()

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/overworld/game_overworld.tscn")
	
