extends VBoxContainer

@export var ordernumber : int
signal orderfufilled(ordernum : int)

func _ready():
	print("Hello World")
	
func _input(event):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed() -> void:
	orderfufilled.emit(ordernumber)
	queue_free()
	pass # Replace with function body.
