extends CharacterBody2D
signal death

@export var SPEED = 25.0
@export var JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravitate = true
var able_to_move = false

func move_to_position(pos):
	position = pos
	
func _process(delta):
	if 708 <= position.y and position.y <= 900:		
		position.y = 1000
		gravitate = false
		velocity = Vector2.ZERO
		
		get_parent().game_state = get_parent().STATE.DEATH
		
		death.emit()
		
	if abs(velocity.x) == 0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = velocity.x < 0
	

func on_slant(delta):
	var start_pos = Vector2(position.x + 9, position.y)
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(start_pos, Vector2(start_pos.x, start_pos.y+35))
	var result = space_state.intersect_ray(query)
	if result:
		if not Vector2(0, -1).is_equal_approx(result["normal"]):
			return result["normal"]
		else:
			return false

func _physics_process(delta):
	if not is_on_floor() and gravitate:
		velocity.y += gravity * delta
	
	if get_parent().game_state == get_parent().STATE.PLAYING:
		var slant_normal = on_slant(delta)

		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		if slant_normal and not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			var slant_direction = Vector2(-slant_normal.y, slant_normal.x)
			var angle_between = acos(slant_direction.dot(Vector2(1, 0)) / (slant_direction.length() * 1))
			var correction = -1 if slant_direction.y <= 0 else 1
			#print(rad_to_deg(angle_between))
			if PI/16 < angle_between:
				velocity.x += correction * slant_direction.x * rad_to_deg(angle_between)
				velocity.y += correction * slant_direction.y * rad_to_deg(angle_between)
			
		var direction = Input.get_axis("move_left", "move_right")
		if able_to_move and direction:
			if (velocity.x < 0 and direction > 0) or (velocity.x > 0 and direction < 0):
				velocity.x = 0
			velocity.x += direction * SPEED
		elif velocity.y != 0:
			velocity.x = move_toward(velocity.x, 0, 5)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		velocity.x = clamp(velocity.x, -225, 225)
	else:
		velocity.x = move_toward(velocity.x, 0, 6)
		
	move_and_slide()
