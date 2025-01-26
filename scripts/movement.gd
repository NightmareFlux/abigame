extends CharacterBody2D

var speed = 175  # Movement speed
var is_attacking = false # 
var attack_cooldown = 0 # Time between attacks
var attack_timer = 0.85 # Timer to manage attack cooldown
var weave_timer = 0.35 # Time before animation ends to do new moves
var last_direction = 0  # Stores the last direction for idle and attack animations

# Helper function to map input_dir to an 8-direction index
func get_8_direction(input_dir: Vector2) -> int:
	var angle = input_dir.angle()
	angle = wrapf(angle, -PI, PI)

	if angle >= -PI / 8 and angle < PI / 8:  # Right
		return 0
	elif angle >= PI / 8 and angle < 3 * PI / 8:  # Bottom-right
		return 1
	elif angle >= 3 * PI / 8 and angle < 5 * PI / 8:  # Down
		return 2
	elif angle >= 5 * PI / 8 and angle < 7 * PI / 8:  # Bottom-left
		return 3
	elif angle >= 7 * PI / 8 or angle < -7 * PI / 8:  # Left
		return 4
	elif angle >= -7 * PI / 8 and angle < -5 * PI / 8:  # Top-left
		return 5
	elif angle >= -5 * PI / 8 and angle < -3 * PI / 8:  # Up
		return 6
	elif angle >= -3 * PI / 8 and angle < -PI / 8:  # Top-right
		return 7
	else:
		return last_direction  # Fallback

# Function to handle attacks
func attack():
	attack_cooldown = attack_timer
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("attack" + str(last_direction))
	# Add your attack logic here (e.g., damage enemies, spawn effects)
	return

func _physics_process(delta):
	

	# Handle input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
		# Handle attack input
	if Input.is_action_just_pressed("attack") && attack_cooldown <= weave_timer:
		is_attacking = true
		print("is_attacking = ", is_attacking)
		attack()
		return  # Skip movement/idle animations during attack

	# Reduce attack timer
	print("attack_cd = ", attack_cooldown)
	if (attack_cooldown <= 0.0) && (is_attacking):
		print("attack stopped")
		is_attacking = false
	elif (attack_cooldown >= 0.0):
		attack_cooldown -= delta
		is_attacking = true

	# Handle attacking state
#	if is_attacking:
#		if !$AnimatedSprite2D.is_playing():
#			is_attacking = true  # Reset attacking state when animation ends
#		return  # Skip movement during attack

	if (is_attacking):
		velocity = input_dir * speed*0.2
	else:
		velocity = input_dir * speed
	
#	if (!is_attacking):
	move_and_slide()
	
	# Handle movement animations
	if (input_dir.length() > 0) && (!is_attacking):
		var direction = get_8_direction(input_dir)
		last_direction = direction
		if $AnimatedSprite2D.animation != "run" + str(direction):
			$AnimatedSprite2D.play("run" + str(direction))
			
	elif (!is_attacking):
		# Handle idle animations
		if $AnimatedSprite2D.animation != "idle" + str(last_direction):
			$AnimatedSprite2D.play("idle" + str(last_direction))




