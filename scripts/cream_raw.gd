extends RigidBody2D

var sumdelta = 0
@export var notfirst = false
@export var itemname : String = ""

func _ready():
	#GlobalSignal..connect(_on_inventory_update)
	self.freeze = false
	if (not notfirst):
		self.freeze = true
	notfirst = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (not self.freeze):
		sumdelta += delta
		#print(sumdelta)
		if sumdelta >= 3:
			self.freeze = true
		
