extends CharacterBody2D

const GRAVITY = 15
const SPEED = 10
const SPRINT = 3000
const HIT_AND_JUMP = 600
const JUMPSPEED = 500
var sprinting = false
var jump_offset = Vector2(10, 0)
var run_offset = Vector2(10, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	idle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	idle()
	vertical_motion()
	horizontal_motion()
	move_and_slide()
	
func idle():
	$"AnimatedSprite2D".play("Idle")
	
func jump(reverse = false):
	if reverse:
		$AnimatedSprite2D.scale.x = -1
		position -= jump_offset
	else:
		$AnimatedSprite2D.scale.x = 1
		position += jump_offset
	$AnimatedSprite2D.play("Jump")
	
func run(reverse = false):
	
	if reverse:
		$AnimatedSprite2D.scale.x = -1
		position -= run_offset
	else:
		$AnimatedSprite2D.scale.x = 1
		position += run_offset
	$AnimatedSprite2D.play("Run")

func horizontal_motion():
	if Input.is_action_pressed("Left"):
		velocity.x = -SPEED
		print(velocity.x)
		print("left")
		if is_on_floor():
			run(true)
		else:
			jump(true)
	elif Input.is_action_pressed("Right"):
		velocity.x = SPEED
		print(velocity.x)
		print("right")
		if is_on_floor():
			run()
		else:
			jump()
	else:
		velocity.x = 0
		idle()

func vertical_motion():
	velocity.y += 10
	
	if Input.is_action_just_pressed("Down") and not is_on_floor():
		velocity.y = SPRINT
		sprinting = true
		
	if is_on_floor() and sprinting:
		velocity.y = -HIT_AND_JUMP
		sprinting = false
	
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = -JUMPSPEED
