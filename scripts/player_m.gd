extends CharacterBody2D

@export var speed: float = 200.0 # Speed in pixels/sec
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Get movement input
	var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Apply movement
	velocity = direction * speed
	move_and_slide()

	# Animation logic
	if direction == Vector2.ZERO:
		anim_sprite.play("idle")  # No movement → idle animation
	else:
		# Play walk/run animation
		# If you only have 1 walk animation
		anim_sprite.play("run")

		# Optional: flip horizontally when moving left
		if direction.x != 0:
			anim_sprite.flip_h = direction.x > 0
