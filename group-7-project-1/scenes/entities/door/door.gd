extends Area2D

##Determines wheither or not the door is locked.
@export var locked : bool;
##Determines wheither or not the door is going up or down stairs.
@export var direction : String;

@onready var open = preload("res://assets/door/door-open.png");
@onready var closed = preload("res://assets/door/door-closed.png");

##This door is going up-stairs
signal going_up;
##This door is going Down-Stairs
signal going_down;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;

func init(_direction : String, _position : Vector2i, _locked : bool) -> void:
	position = _position;
	locked = _locked;
	direction = _direction;
	if locked: $Sprite2D.texture = closed;
	else: $Sprite2D.texture = open;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if not locked:
		match direction:
			"up": going_up.emit();
			"down": going_down.emit();
	elif locked and body.has_key(): 
		locked = false;
		$Sprite2D.texture = open;
		await get_tree().create_timer(1).timeout;
		match direction:
			"up": going_up.emit();
			"down": going_down.emit();
	else:
		pass;
