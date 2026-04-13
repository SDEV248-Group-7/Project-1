extends CharacterBody2D;

signal ghost_died(size : String);

@export var move_speed : int = 1;

@onready var PLAYER : CharacterBody2D;

func init(_player : CharacterBody2D, _position : Vector2):
	PLAYER = _player;
	position = _position;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = position.direction_to(PLAYER.position);
	position = direction * move_speed;


func hurt():
	ghost_died.emit("large");
	queue_free();
