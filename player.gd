extends RigidBody2D

@export var ground_speed = 400
@export var air_speed = 100
@export var jump_force = 600
@export var slope_speed = 600
var jumping = false
var able_right = true
var able_left = true
var able_to_move = true

# Called when the node enters the scene tree for the first time.
func _ready():
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if abs(linear_velocity.x) == 0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = linear_velocity.x < 0
	#print(delta)
	
func _move_to_position(pos):
	position = pos	

func _integrate_forces(state):
	#print(state.get_linear_velocity())
	if able_to_move:
		var velocity = state.get_linear_velocity()
		var step = state.get_step()
		var angle
		var direction = Vector2.ZERO
		
		for x in range(state.get_contact_count()):
			var local_normal = state.get_contact_local_normal(x)
			var angle_between = acos(local_normal.dot(Vector2(0, -1))/(local_normal.length()))
			#print(round(rad_to_deg(angle_between)))
		
			if 0 <= angle_between and angle_between < PI/2:
				angle = angle_between
				direction = Vector2(-local_normal.y, local_normal.x)
				jumping = false
				if !able_right:
					able_right = true
				if !able_left:
					able_left = true
			elif state.get_contact_local_normal(x) == Vector2(-1, 0):
				able_right = false
			elif state.get_contact_local_normal(x) == Vector2(1, 0):
				able_left = false
				
		if Input.is_action_pressed("jump") and !jumping:
			velocity.y -= jump_force * step * 20
			jumping = true
		
		if !jumping:
			if angle != null and 0 <= angle and angle < PI/2:
				if direction == Vector2(1, 0):
					if Input.is_action_pressed("move_right") and velocity.x < 200:
						velocity.x += ground_speed * step * 10
					elif Input.is_action_pressed("move_left") and velocity.x > -200:
						velocity.x -= ground_speed * step * 10
				else:
					if Input.is_action_pressed("move_left"):
						direction *= -1
					if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
						velocity = direction.normalized() * slope_speed * step * 20
		else:
			if Input.is_action_pressed("move_right") and able_right and velocity.x < 200:
				if velocity.x < 0:
					velocity.x = 0
				velocity.x += air_speed * step * 10
			elif Input.is_action_pressed("move_left") and able_left and velocity.x > -200:
				if velocity.x > 0:
					velocity.x = 0
				velocity.x -= air_speed * step * 10
			
		state.set_linear_velocity(velocity)	


func _on_door_advance():
	able_to_move = false
