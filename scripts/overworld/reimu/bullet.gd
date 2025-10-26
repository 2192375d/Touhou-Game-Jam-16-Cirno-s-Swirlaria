extends Area2D

class_name Bullet

@export var bullet_resource: BulletResource
@export var collision_shape: CollisionShape2D
@export var sprite: Sprite2D

var dir: float
var speed: float

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position += Vector2(speed * cos(dir) * delta, speed * sin(dir) * delta)

func set_bullet(new_dir: float, new_speed: float):
	self.dir = new_dir
	self.speed = new_speed
	
	collision_shape.shape = bullet_resource.shape
	sprite.texture = bullet_resource.texture
	
	rotate(-dir)
