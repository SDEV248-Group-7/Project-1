extends CharacterBody2D

# Movement
var speed = 200
var facing_left = false

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	handle_movement()
	move_and_slide()


func handle_movement():
	var direction = Vector2.ZERO

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed

		
		if direction.x != 0:
			facing_left = direction.x < 0
			anim.flip_h = facing_left


		play_move_animation(direction)

	else:
		velocity = Vector2.ZERO
		anim.stop()  



func play_move_animation(direction):
	if abs(direction.x) > abs(direction.y):
		anim.play("right")   
	elif direction.y > 0:
		anim.play("down")
	else:
		anim.play("up")
