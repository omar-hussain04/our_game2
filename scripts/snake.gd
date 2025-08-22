extends Node2D

const SPEED = 60
@export var health: int = 3  # عدد الضربات قبل الموت

var direction = 1

@onready var raycast_r: RayCast2D = $raycastR
@onready var raycast_l: RayCast2D = $raycastL
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	# الحركة يمين/يسار حسب التصادم مع الجدران
	if raycast_r.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
		
	if raycast_l.is_colliding():
		direction = 1
		animated_sprite.flip_h = true

	position.x += direction * SPEED * delta

# دالة استدعاء عند تلقي ضربة
func take_damage(amount: int) -> void:
	health -= amount
	print("العدو انضرب! الصحة: %d" % health)
	if health <= 0:
		queue_free()  # حذف العدو من المشهد
