extends RigidBody2D

var sumdelta = 0
static var notfirst = false

func _ready():
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
	if (self.position.y >= 1200):
		queue_free()
		
