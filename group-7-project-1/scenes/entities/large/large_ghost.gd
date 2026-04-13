extends Area2D;

signal ghost_died(size : String);

@export var move_speed : int;

@onready var player = get_node("../../../Player");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var direction = position.direction_to(player.position);
	
	position = direction * move_speed;

func hurt():
	ghost_died.emit("large");
	queue_free();
