extends CharacterBody2D

const GRAVITY = 3000
const SPEED = 400
const JUMPSPEED = 1000
var animatedPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animatedPlayer = $"AnimatedSprite2D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta 
		animatedPlayer.play("jump")
	else:
		animatedPlayer.play("idle")

	if Input.is_action_pressed("Left"):
		animatedPlayer.play("run")
		animatedPlayer.scale.x = -1
		velocity.x = -SPEED
	elif Input.is_action_pressed("Right"):
		animatedPlayer.play("run")
		animatedPlayer.scale.x = 1
		velocity.x = SPEED
	else:
		velocity.x = 0
		
	
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y -= JUMPSPEED
		
	move_and_slide()
