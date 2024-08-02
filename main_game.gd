extends Node2D

@export var level = 1
var door_positions = [Vector2(1105, 322)]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player._move_to_position($Marker2D.position)
	$Door.go_to_position(door_positions[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
