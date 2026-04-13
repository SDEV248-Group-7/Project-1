extends CharacterBody2D;

signal ghost_died(size : String);

# Should move away from player, bound by enviroment
# Low health,
# Does damage to player if touched
# dealth damage to it if hit by player

@export var move_speed : int = 100;

@onready var PLAYER : CharacterBody2D;

func init(_player : CharacterBody2D, _position : Vector2):
	PLAYER = _player;
	position = _position;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var direction = -(position.direction_to(PLAYER.position));
	velocity = direction * move_speed;
	move_and_slide();


func hurt():
	ghost_died.emit("small");
	queue_free();
