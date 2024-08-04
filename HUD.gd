extends Control
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_hud()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_text(text, color):
	$CanvasLayer/Text.text = text
	$CanvasLayer/Text.set("theme_override_colors/font_color", color)

func reset_hud():
	$CanvasLayer/Text.position = Vector2(125, 700)
	
	$CanvasLayer/RestartButton.position = Vector2(358, 869)
	$CanvasLayer/StartButton.position = Vector2(510, 869)
	
	if get_parent().game_state == get_parent().STATE.OPENING:
		$CanvasLayer/MenuButton.position = Vector2(650, 869)
		
		change_text("Just a Platformer", Color("3aad00"))
		$CanvasLayer/ColorRect.color = Color(0, 0, 0, 0)
		$CanvasLayer/MenuButton.icon = ResourceLoader.load("res://art/buttons/menuW.png")
		
		$CanvasLayer/ColorRect.show()
	elif get_parent().game_state == get_parent().STATE.WIN:
		$CanvasLayer/MenuButton.position = Vector2(510, 869)
		
		change_text("Truly Just a Platformer", Color("c1bf00"))
		$CanvasLayer/ColorRect.color = Color(0, 0, 0, 0)
		$CanvasLayer/MenuButton.icon = ResourceLoader.load("res://art/buttons/menu.png")
	else:
		$CanvasLayer/MenuButton.position = Vector2(650, 869)
		
		change_text("Game Over", Color("ff0000"))
		
		$CanvasLayer/ColorRect.hide()

func _on_player_death():
	$CanvasLayer/ColorRect.show()
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("death_load")
	
	get_parent().game_state = get_parent().STATE.WAITING
	
func _on_restart_button_pressed():
	reset_hud()
	start_game.emit()

func _on_start_button_pressed():
	reset_hud()
	start_game.emit()

func _on_menu_button_pressed():
	get_parent().game_state = get_parent().STATE.OPENING
	reset_hud()
	start_game.emit()
	
