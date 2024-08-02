extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		print(child.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_level(curr_level, levels):
	for level in range(levels):
		var child = get_children()[level]
		if curr_level - 1 == level:
			child.visible = true
			child.diabled = false
		else:
			child.visible = false
			child.set_deferred("disabled", true)
			
