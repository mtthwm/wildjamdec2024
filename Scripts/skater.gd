extends CharacterBody3D

const SPEED = 8
const TURN_SPEED = 0.08
const ATTACK_DELAY = 0.4
const DAMAGE_DELAY = 0.5
#const JUMP_VELOCITY = 4.5
var health = 5

@onready var attack_timer: Timer = $Attack_Timer
@onready var damage_timer: Timer = $Damage_Timer
@onready var playergun: RayCast3D = $aim/RayCast3D
@onready var healthbar: ProgressBar = $"../Camera3D2/HealthBar"

var bullet = load("res://Scenes/Game/bullet.tscn")
var pointer = velocity


func _ready() -> void:
	pointer.z = -1 * SPEED
	attack_timer.start(ATTACK_DELAY)

# if 'direction' is +1, the character turns left a fixed amount. 
# if 'direction' is -1, the character turns right.
func turn(direction: int) -> void:
	rotate_y(direction * TURN_SPEED)
	pointer.x = pointer.rotated(Vector3.UP, direction * TURN_SPEED).x
	pointer.z = pointer.rotated(Vector3.UP, direction * TURN_SPEED).z

# controls the movement of the character. Key inputs control turns.
func _physics_process(delta: float) -> void:
	velocity = pointer.normalized() * SPEED
	
	if Input.is_action_pressed("w_pressed", false):
		if pointer.angle_to(Vector3(-1,0,0)) > PI/2:
			turn(1)
		else: 
			turn(-1)
	
	if Input.is_action_pressed("a_pressed", false):
		if pointer.angle_to(Vector3(0,0,1)) > PI/2:
			turn(1)
		else: 
			turn(-1)

	if Input.is_action_pressed("s_pressed", false):
		if pointer.angle_to(Vector3(1,0,0)) > PI/2:
			turn(1)
		else: 
			turn(-1)

	if Input.is_action_pressed("d_pressed", false):
		if pointer.angle_to(Vector3(0,0,-1)) > PI/2:
			turn(1)
		else: 
			turn(-1)
	
	if Input.is_action_pressed("q_pressed", false):
		turn(1)
		
	if Input.is_action_pressed("e_pressed", false): 
		turn(-1)
	
	#Shoot
	if (Input.is_action_pressed("left_mouse_click", false) 
	&& attack_timer.is_stopped()):
		var instance = bullet.instantiate()
		instance.position = playergun.global_position
		instance.transform.basis = playergun.global_transform.basis
		get_parent().add_child(instance)
		attack_timer.start(ATTACK_DELAY)
	
	#  # Add the gravity.
	#  if not is_on_floor():
	#  	velocity += get_gravity() * delta
	
	#  # Handle jump.
	#  if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#  	velocity.y = JUMP_VELOCITY
	
	move_and_slide()

# if the skater hasn't been hit in 1 second or more, take damage
func _take_damage(damage: int) -> void:
	if damage_timer.is_stopped():
		health = health - damage
		healthbar.value = health
		damage_timer.start(DAMAGE_DELAY)
		print("Ouch!")
		print("health remaining: " + str(health))
	
		if health <= 0:
			get_parent().queue_free()
			process_mode = Node.PROCESS_MODE_DISABLED
			var game_over = load("res://Scenes/Homescreen/game_over.tscn").instantiate()
			get_tree().root.add_child(game_over)
	
