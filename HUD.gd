extends CanvasLayer
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_hud()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func reset_hud():
	$RestartButton.position = Vector2(510, 869)
	$StartButton.position = Vector2(510, 869)
	if get_parent().game_state == get_parent().STATE.OPENING:
		$Text.position = Vector2(164, 700)
		
		$Text.text = "Just a Platformer"
		$Text.set("theme_override_colors/font_color", Color("3aad00"))
		$ColorRect.color = Color(0, 0, 0, 0)
	else:
		$Text.position = Vector2(291, 700)
		
		$Text.text = "Game Over"
		$Text.set("theme_override_colors/font_color", Color("ff0000"))
		
		$ColorRect.hide()

func _on_player_death():
	$ColorRect.show()
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("death_load")
	
func _on_restart_button_pressed():
	reset_hud()
	start_game.emit()

func _on_start_button_pressed():
	reset_hud()
	start_game.emit()
