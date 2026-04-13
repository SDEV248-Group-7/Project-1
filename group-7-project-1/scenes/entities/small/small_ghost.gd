extends Area2D;

signal ghost_died(size : String);

# Should move away from player, bound by enviroment
# Low health,
# Does damage to player if touched
# dealth damage to it if hit by player

@export var move_speed : int = 0;

@onready var player = get_node("../../../Player");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var direction = -(position.direction_to(player.position));
	
	position = direction * move_speed;


func hurt():
	ghost_died.emit("small");
	queue_free();
