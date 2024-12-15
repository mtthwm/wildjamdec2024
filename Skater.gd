extends CharacterBody3D

const SPEED = 10
const TURN_SPEED = 0.05
#const JUMP_VELOCITY = 4.5

func _ready() -> void:
	velocity.z = -1 * SPEED
	
# if 'direction' is +1, the character turns left a fixed amount. 
# if 'direction' is -1, the character turns right.
func turn(direction: int) -> void:
	rotate_y(direction * TURN_SPEED)
	velocity.x = velocity.rotated(Vector3.UP, direction * TURN_SPEED).x
	velocity.z = velocity.rotated(Vector3.UP, direction * TURN_SPEED).z

# controls the movement of the character. key inputs control turns.
func _physics_process(delta: float) -> void:
	velocity = velocity.normalized() * SPEED
	
	if Input.is_action_pressed("w_pressed", false):
		if velocity.angle_to(Vector3(-1,0,0)) > PI/2:
			turn(1)
		else: 
			turn(-1)

	if Input.is_action_pressed("a_pressed", false):
		if velocity.angle_to(Vector3(0,0,1)) > PI/2:
			turn(1)
		else: 
			turn(-1)

	if Input.is_action_pressed("s_pressed", false):
		if velocity.angle_to(Vector3(1,0,0)) > PI/2:
			turn(1)
		else: 
			turn(-1)

	if Input.is_action_pressed("d_pressed", false):
		if velocity.angle_to(Vector3(0,0,-1)) > PI/2:
			turn(1)
		else: 
			turn(-1)
	
	if Input.is_action_pressed("q_pressed", false):
		turn(1)
		
	if Input.is_action_pressed("e_pressed", false): 
		turn(-1)

	#  # Add the gravity.
	#  if not is_on_floor():
	#  	velocity += get_gravity() * delta

	#  # Handle jump.
	#  if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#  	velocity.y = JUMP_VELOCITY

	move_and_slide()
