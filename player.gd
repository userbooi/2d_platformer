extends RigidBody2D

@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(10, 10)
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	elif Input.is_action_pressed("move_left"):
		velocity.x = -1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta * 400
		
	apply_force(velocity)
		
	
