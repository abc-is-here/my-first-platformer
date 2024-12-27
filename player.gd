extends CharacterBody2D

var move_speed: float = 100.0
var jump_force: float = 200.0
var gravity: float = 500.0
var dash_speed: float = 300.0
var dash_duration: float = 0.2
var dash_cooldown: float = 1.5
var score: int = 0

var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_ready: bool = true
var dash_cooldown_timer: float = 0.0

@onready var score_text: Label = get_node("score/scoreText")

func _physics_process(delta: float) -> void:
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
		move_and_slide()
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = 0

	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
		$sprite.flip_h = false

	if Input.is_action_pressed("right"):
		velocity.x += move_speed
		$sprite.flip_h = true

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jump_force

	if Input.is_action_just_pressed("dash") and dash_ready:
		is_dashing = true
		dash_timer = dash_duration
		dash_ready = false
		$whoosh.play()

		if Input.is_action_pressed("right"):
			velocity.x = dash_speed
		elif Input.is_action_pressed("left"):
			velocity.x = -dash_speed

	if not dash_ready:
		dash_cooldown_timer += delta
		if dash_cooldown_timer >= dash_cooldown:
			dash_ready = true
			dash_cooldown_timer = 0.0

	move_and_slide()

	if global_position.y > 200:
		game_over()

func game_over():
	get_tree().change_scene_to_file("res://game_over.tscn")

func add_score(amount):
	score += amount
	score_text.text = str("Score: ", score)
