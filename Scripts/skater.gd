extends CharacterBody3D

const SPEED = 10
const TURN_SPEED = 0.05
#const JUMP_VELOCITY = 4.5
@onready var timer: Timer = $Timer
@onready var playergun: RayCast3D = $aim/RayCast3D


var bullet = load("res://Scenes/bullet.tscn")
var instance


func _ready() -> void:
	velocity.z = -1 * SPEED
	timer.start()
	
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



#Shoot
	if timer.is_stopped():
		instance = bullet.instantiate()
		instance.position = playergun.global_position
		instance.transform.basis = playergun.global_transform.basis
		get_parent().add_child(instance)
		timer.start()





	#  # Add the gravity.
	#  if not is_on_floor():
	#  	velocity += get_gravity() * delta

	#  # Handle jump.
	#  if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#  	velocity.y = JUMP_VELOCITY

	move_and_slide()
