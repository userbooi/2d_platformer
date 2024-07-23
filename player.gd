extends RigidBody2D

@export var speed = 400
@export var jump_force = 300
var jump = false

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(10, 10)
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print(delta)
	
func _integrate_forces(state):
	#print(state.get_linear_velocity())
	var velocity = state.get_linear_velocity()
	var step = state.get_step()
	
	
	if Input.is_action_pressed("move_right") and velocity.x < 200:
		velocity.x += speed * step * 20
	elif Input.is_action_pressed("move_left") and velocity.x > -200:
		velocity.x -= speed * step * 20
		
	state.set_linear_velocity(velocity)	
	
