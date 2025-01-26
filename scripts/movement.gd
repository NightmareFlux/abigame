extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
const speed = 100
var current_dir = "none"

func _ready():
	anim.play("idle")

func player_movement(_delta):
	if Input.is_action_pressed("move_right"):
		play_anim(1, "right")
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		play_anim(1, "left")
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		play_anim(1, "down")
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("move_up"):
		play_anim(1, "up")
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0, "up")
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

func play_anim(movement, dir):

	if dir == "right":
		anim.flip_h = false
		anim.play("walk")
		print(dir)

	if dir == "left":
		anim.flip_h = true
		anim.play("walk")
		print(dir)

		if dir == "up":
			anim.flip_h = true
			if movement == 1:
				anim.play("walk")
			elif movement == 0:
				anim.play("idle")

	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk")
		elif movement == 0:
			anim.play("idle")
