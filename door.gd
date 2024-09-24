extends Area2D
signal advance


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func go_to_position(pos):
	position = pos
	$AnimationPlayer.play(&"RESET")
	$door_door.modulate.a = 1


func _on_body_entered(body):
	if body.name == "NewPlayer":
		$AnimationPlayer.play("fading_door")
		
		advance.emit()
