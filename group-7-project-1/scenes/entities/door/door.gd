extends Area2D

##Determines wheither or not the door is locked.
@export var locked : bool;
##Determines wheither or not the door is going up or down stairs.
@export var direction : String;

##This door is going up-stairs
signal going_up;
##This door is going Down-Stairs
signal going_down;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init(_direction : String, _position : Vector2i, _locked : bool) -> void:
	position = _position;
	locked = _locked;
	direction = _direction;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	match direction:
		"up": going_up.emit();
		"down": going_down.emit();
