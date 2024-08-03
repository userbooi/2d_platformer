extends Node2D

@export var level = 1
@export var levels = 2
var door_positions = [Vector2(1105, 322), Vector2(1065, 387)] # subtract 68 to y value
var player_positions = [Vector2(60, 525), Vector2(69, 265)] # subtract 60 to y value
var start_game_position = Vector2(60, -1598)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.move_to_position(start_game_position)
	$Levels.show_level(level, levels)
	$Door.hide()
	start_game_cutscene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func start_game_cutscene():
	if $Player.position.y >= 322:
		pass

func begin():
	level = 1
	
	$Player.move_to_position(player_positions[level-1])
	$Player.set_gravity_scale(1)
	$Door.go_to_position(door_positions[level-1])
	$Levels.show_level(level, levels)

func _on_door_advance():
	await get_tree().create_timer(2.0).timeout
	level += 1
	if level <= levels:
		set_up_level()
	else:
		pass
	
func set_up_level():
	await get_tree().create_timer(0.5).timeout
	
	$AnimationPlayer.play("to_black")
	
	await get_tree().create_timer(1.5).timeout
	
	$Player.move_to_position(player_positions[level-1])
	$Door.go_to_position(door_positions[level-1])
	$Levels.show_level(level, levels)
	
	$AnimationPlayer.play("fade_out")
	
	$Player.able_to_move = true
		
	
