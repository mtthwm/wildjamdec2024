extends CharacterBody3D


const SPEED = 0.02
const ATTACK_DELAY = 1
var health = 1

@onready var timer: Timer = $"Timer"
@onready var shooter: RayCast3D = $"RayCast3D"

var carrot = load("res://Scenes/Game/carrot.tscn")

func _ready() -> void:
	pass

# moves towards the player every frame
func _physics_process(delta: float) -> void:
	var skater = get_node("/root/Game/Skater")
	var target = skater.get_position()
	
	var path = target - position
	velocity = path.normalized() * SPEED
	look_at(target, Vector3.UP)
	
	var collision = move_and_collide(velocity)
	
	# check for a player to attack
	if collision is KinematicCollision3D:
		if collision.get_collider() == skater:
			skater._take_damage(1)

	if timer.is_stopped() && path.length() <= 12:
		var instance = carrot.instantiate()
		instance.position = position
		shooter.global_transform.origin = target + Vector3(0, 1, 0)
		instance.transform.basis = shooter.global_transform.basis
		
		get_parent().get_parent().add_child(instance)
		timer.start(ATTACK_DELAY)
	
	rotate_y(-PI/2) # the model isn't forward by default
	

func _take_damage(damage: int) -> void:
	health = health - damage
	if health <= 0:
		queue_free()
