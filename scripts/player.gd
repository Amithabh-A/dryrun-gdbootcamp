extends CharacterBody2D

const GRAVITY = 3000
const SPEED = 400
const JUMPSPEED = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	print(5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta 

	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y -= JUMPSPEED
		
	move_and_slide()
