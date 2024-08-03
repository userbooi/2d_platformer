extends CanvasLayer
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_hud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func reset_hud():
	$Text.position = Vector2(291, 700)
	$RestartButton.position = Vector2(510, 869)
	$ColorRect.hide()

func _on_player_death():
	$ColorRect.show()
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("death_load")
	
func _on_restart_button_pressed():
	reset_hud()
	start_game.emit()
