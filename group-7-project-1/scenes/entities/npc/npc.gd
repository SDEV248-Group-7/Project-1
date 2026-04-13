extends CharacterBody2D;

signal gameover(reason : String);

@export var move_speed = 50;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y = move_speed;
	move_and_slide();

func _on_timer_timeout() -> void:
	gameover.emit("freed");
