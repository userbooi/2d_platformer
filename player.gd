extends RigidBody2D

@export var ground_speed = 400
@export var air_speed = 100
@export var jump_force = 600
var jumping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print(delta)
	
func _move_to_position(pos):
	position = pos	

func _integrate_forces(state):
	#print(state.get_linear_velocity())
	var velocity = state.get_linear_velocity()
	var step = state.get_step()
	
	for x in range(state.get_contact_count()):
		if state.get_contact_local_normal(x) == Vector2(0, -1):
			#print("floor")
			jumping = false
			
	if Input.is_action_pressed("jump") and !jumping:
		velocity.y -= jump_force * step * 20
		jumping = true
	
	if !jumping:
		if Input.is_action_pressed("move_right") and velocity.x < 200:
			velocity.x += ground_speed * step * 10
		elif Input.is_action_pressed("move_left") and velocity.x > -200:
			velocity.x -= ground_speed * step * 10
	else:
		if Input.is_action_pressed("move_right") and velocity.x < 200:
			velocity.x += air_speed * step * 10
		elif Input.is_action_pressed("move_left") and velocity.x > -200:
			velocity.x -= air_speed * step * 10
		
	state.set_linear_velocity(velocity)	
	
