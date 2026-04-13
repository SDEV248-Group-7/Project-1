extends CharacterBody2D

# Movement
@export var speed = 200
var facing_left = false
var direction = Vector2.ZERO;

#Life/Death Variables
@export var life = 3;
signal gameover(reason : String);
signal life_changed(new_life : int);

@onready var anim = $AnimatedSprite2D

@onready var key_held : bool = false;

@onready var fine : bool = true;

func _ready() -> void:
	$Right_Weapon.hide();
	$Left_Weapon.hide();
	$Up_Weapon.hide();
	$Down_Weapon.hide();


func _physics_process(delta):
	handle_movement()
	check_for_attack();
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i);
		if collision.get_collider().is_in_group("ghost"):
			collision.get_collider().hurt();
			if(fine):
				fine = false;
				hurt();


func handle_movement():
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed

		
		if direction.x != 0:
			facing_left = direction.x < 0
			anim.flip_h = facing_left


		play_move_animation()

	else:
		velocity = Vector2.ZERO
		anim.stop()  


func play_move_animation():
	if abs(direction.x) > abs(direction.y):
		anim.play("right")   
	elif direction.y > 0:
		anim.play("down")
	else:
		anim.play("up")


func check_for_attack():
	var attack = Input.is_action_pressed("attack");
	if attack:
		pass
	pass;


func hurt():
	life -= 1;
	life_changed.emit(life);
	if life <= 0:
		gameover.emit("died");
	
	fine = true;


func has_key():
	return key_held;
