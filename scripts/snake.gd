extends Node2D

const SPEED = 60

var direction = 1

@onready var raycast_r: RayCast2D = $raycastR
@onready var raycast_l: RayCast2D = $raycastL
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if raycast_r.is_colliding():
		direction = -1
		animated_sprite.flip_h =false
		
	if raycast_l.is_colliding():
		direction = 1
		animated_sprite.flip_h =true

	position.x += direction * SPEED * delta
