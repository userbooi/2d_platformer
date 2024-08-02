extends Node2D

@export var level = 1
@export var levels = 2
var door_positions = [Vector2(1105, 322), Vector2(1065, 387)] # subtract 68 to y value
var player_positions = [Vector2(100, 525), Vector2(69, 265)] # subtract 60 to y value

# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_door_advance():
	await get_tree().create_timer(2.0).timeout
	level += 1
	set_up_level()
	
func set_up_level():
	$Player._move_to_position(player_positions[level-1])
	$Door.go_to_position(door_positions[level-1])
	#$Levels.show_level(level, levels)
