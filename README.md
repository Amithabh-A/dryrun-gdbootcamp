## Before Start

- Create folders `assets`, `scripts` and `scenes` below `res`

## Building Game

- Create a 2D scene, and rename it to `Game`
- Save it in `scenes`

## Building Player

- Create a new scene
- Click `+` top left, get a `CharacterBody2D` Node
- Rename it to `Player`
- Add `AnimatedSprite2D` to Player. Inspector -> animations -> sprite frames -> select sprite frame -> resources, drag your icon.svg to resource.
- Add `CollisionShape2D` to player. Inspector -> shape -> rectangle. Adjust the rectangle to fit logo's shape
- Lock the player.

## Building Game

- Instantiate player : right click game -> instantiate Child scene
- Add camera to game: `+` top left -> Camera2D
- Lock game

## Ground

- Under Game, create `StaticBody2D` -> create a `CollisionShape2D` and `Sprite2D` as children -> rename `StaticBody2D` to `Ground` -> Add collision shape rect -> On sprite, click `<empty>` of Texture in Inspector -> Load -> `icon.svg`

`v = u + at`

```gdscript
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide
```
