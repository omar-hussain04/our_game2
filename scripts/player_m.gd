extends CharacterBody2D

@export var speed: float = 200.0
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackAreaء
#func _ready() -> void:
	#attack_area.monitoring = false 
	#attack_area.body_entered.connect(_on_attack_area_hit_body)
	#attack_area.area_entered.connect(_on_attack_area_hit_area)

func _physics_process(delta: float) -> void:
	# الحركة
	var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

	# الأنيميشن
	if direction == Vector2.ZERO:
		anim_sprite.play("idle")
	else:
		anim_sprite.play("run")
		if direction.x != 0.0:
			anim_sprite.flip_h = direction.x > 0.0

	# الضرب
	if Input.is_action_just_pressed("attack"):
		_attack()

func _attack() -> void:
	anim_sprite.play("hit")

	# تحريك منطقة الضرب حسب الاتجاه
	var base_x := 20.0
	#attack_area.position.x = base_x if anim_sprite.flip_h else -base_x

	#attack_area.monitoring = true
	await get_tree().create_timer(0.2).timeout
	#attack_area.monitoring = false

func _on_attack_area_hit_body(body: Node) -> void:
	var victim := body
	if not victim.has_method("take_damage") and victim.get_parent():
		victim = victim.get_parent()
	if victim.has_method("take_damage"):
		victim.take_damage(1)

func _on_attack_area_hit_area(area: Area2D) -> void:
	var victim := area
	if not victim.has_method("take_damage") and victim.get_parent():
		victim = victim.get_parent()
	if victim.has_method("take_damage"):
		victim.take_damage(1)
