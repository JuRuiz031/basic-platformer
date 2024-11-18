extends CharacterBody2D

enum State { IDLE, CHASE, DEATH }  # Define possible states
var state = State.IDLE  # Initialize state to IDLE

# Player variable for AI script, using onready
@onready var player = get_node("../../Player/Player")  # Directly reference the player node
# Set up base speed
var SPEED = 50

# Set up gravity and physics process for the frog
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	velocity.y += gravity * delta  # Apply gravity
	
	match state:
		State.IDLE:
			set_animation("Idle")
			velocity.x = 0

		State.CHASE:
			# Play "Jump" animation and handle movement
			set_animation("Jump")
			var direction = (player.global_position - self.global_position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = true
			else:
				get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED

		State.DEATH:
			# Stop all movement during death
			velocity.x = 0
			velocity.y = 0

	move_and_slide()

# Player Detection Functions
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player" and state != State.DEATH:
		state = State.CHASE

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player" and state != State.DEATH:
		state = State.IDLE

# Player Death Function
func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == "Player" and state != State.DEATH:
		death()
		
# Player Collision Function
func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player" and state != State.DEATH:
		Game.playerHP -= 2
		Game.Gold += 5
		Utils.saveGame()
		death()
	
func death():
	state = State.DEATH
	set_animation("Death")
	# Wait for the animation to finish, then delete the frog
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
	
# Set animation function
func set_animation(animation_name: String):
		var sprite = get_node("AnimatedSprite2D")
		if sprite.animation != animation_name:
			sprite.play(animation_name)
