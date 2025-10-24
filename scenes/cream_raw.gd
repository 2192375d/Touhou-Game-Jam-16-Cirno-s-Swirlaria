extends RigidBody2D

var sumdelta = 0
static var notfirst = false

func _ready():
	self.freeze = false
	if (not notfirst):
		self.freeze = true
	notfirst = true
	print("Hello World")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (not self.freeze):
		sumdelta += delta
		#print(sumdelta)
		if sumdelta >= 3:
			self.freeze = true
			print("freezed")
	if (self.position.y >= 1200):
		print("KMS")
		queue_free()
		
