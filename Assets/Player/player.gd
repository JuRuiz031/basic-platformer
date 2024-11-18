extends CharacterBody2D

var is_dead = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DECELERATION = 40.0

# Prepare the animation sprite for the different animations
@onready var anim = get_node("AnimatedSprite2D")

func _ready() -> void:
	if Game.playerHP <= 0:
		Game.playerHP = 10
		Game.Gold = 0
		Utils.saveGame()

func _physics_process(delta: float) -> void:
	# Handle Health
	if Game.playerHP <= 0 and not is_dead:
		stop_movement()
		handle_death()
		return
	else:
		# Apply gravity
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Movement functions
		handle_jump()
		handle_movement()
	
		# Flip the sprite based on direction
		if velocity.x < 0:
			anim.flip_h = true
		elif velocity.x > 0:
			anim.flip_h = false
	
		# Apply the movement
		move_and_slide()

# Handle movement and jump
func handle_movement() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:  # Player is moving horizontally
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		# Smooth deceleration to 0
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		if velocity.y == 0:
			anim.play("Idle")

func handle_jump() -> void:
		# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
	if velocity.y > 0:
		anim.play("Fall")

#Handle Death/Stop movement
func stop_movement() -> void:
	velocity.x = 0
	velocity.y = 0
	
func handle_death() -> void:
	for i in range(3): # Loop for playing death animation
		anim.play("Death")
		await anim.animation_finished
	# Change scene to main after death
	# This was the only way to work
	get_tree().change_scene_to_file.bind("res://main.tscn").call_deferred()
	queue_free()
