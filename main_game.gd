extends Node2D

enum STATE {OPENING, PLAYING, DEATH, WAITING, WIN}

@export var level = 1
@export var levels = 6
var door_positions = [
	Vector2(1105, 322), 
	Vector2(1065, 387), 
	Vector2(1019, 192),
	Vector2(470, -393),
	Vector2(420, -588),
	Vector2(931, -1107),
] # subtract 68 to y value
var player_positions = [
	Vector2(60, 560), 
	Vector2(69, 290),
	Vector2(66, 430),
	Vector2(57, 40),
	Vector2(195, 40),
	Vector2(125, -350)
] # subtract 25 to y value
var start_game_position = Vector2(60, -1598)

var game_state = STATE.OPENING
#var game_state = STATE.PLAYING

# Called when the node enters the scene tree for the first time.
func _ready():
	begin()
	#if !(int($Player.position.y) == player_positions[level-1].y):
		#$Player.move_to_position(player_positions[level-1])
	#$Player.set_gravity_scale(1)
	#$Player.able_to_move = true
	#$Door.go_to_position(door_positions[level-1])
	#$Door.show()
	#$Levels.show_level(level, levels)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.position.y >= 525 and game_state == STATE.OPENING:
		start_game_cutscene()
	
	
func start_game_cutscene():
	$HUD/AnimationPlayer.play("start_load")
	game_state = STATE.WAITING

func begin():
	$ColorRect.color = Color(0, 0, 0, 0)
	
	if game_state == STATE.OPENING:
		level = 1
		$Player.set_gravity_scale(1)
		$Player.move_to_position(start_game_position)
		$Levels.show_level(level, levels)
		$Door.hide()
	else:
		if !(int($Player.position.y) == player_positions[level-1].y):
			$Player.move_to_position(player_positions[level-1])
		$Player.set_gravity_scale(1)
		$Player.able_to_move = true
		$Door.go_to_position(door_positions[level-1])
		$Door.show()
		$Levels.show_level(level, levels)
		
		game_state = STATE.PLAYING

func _on_door_advance():
	game_state = STATE.WAITING
	await get_tree().create_timer(2.0).timeout
	level += 1
	if level <= levels:
		set_up_level()
	else:
		victory()
	
func set_up_level():
	await get_tree().create_timer(0.5).timeout
	
	$AnimationPlayer.play("to_black")
	
	await get_tree().create_timer(1.5).timeout
	
	$Player.move_to_position(player_positions[level-1])
	$Door.go_to_position(door_positions[level-1])
	$Door.show()
	$Levels.show_level(level, levels)
	
	$AnimationPlayer.play("fade_out")
	
	game_state = STATE.PLAYING
	
func victory():
	game_state = STATE.WIN
	
	$AnimationPlayer.play("to_white")
	
	await get_tree().create_timer(3.0).timeout
	
	$HUD.reset_hud()
	$HUD/AnimationPlayer.play("win_load")
