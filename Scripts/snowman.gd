extends CharacterBody3D


const SPEED = 0.02
const ATTACK_DELAY = 1
var health = 2

@onready var timer: Timer = $"Timer"
@onready var skater: CharacterBody3D = $"../../skater"

@onready var shooter: RayCast3D = $"RayCast3D"
@onready var camera: Camera3D = $"../../Camera3D2"

var carrot = load("res://Scenes/Game/carrot.tscn")

func _ready() -> void:
	pass

# moves towards the player every frame
func _physics_process(delta: float) -> void:
	var skater = get_node("/root/Game/Skater")
	var target = skater.get_position()
	
	velocity = target - position
	velocity = velocity.normalized() * SPEED
	look_at(target, Vector3.UP)
	
	var collision = move_and_collide(velocity)
	
	# check for a player to attack
	if collision is KinematicCollision3D:
		if collision.get_collider() == skater:
			skater._take_damage(1)

	if timer.is_stopped():
		var instance = carrot.instantiate()
		instance.position = position
		shooter.global_transform.origin = target + Vector3(0, 1, 0)
		instance.transform.basis = shooter.global_transform.basis
		
		get_parent().get_parent().add_child(instance)
		timer.start(ATTACK_DELAY)
	

func _take_damage(damage: int) -> void:
	health = health - damage
	if health <= 0:
		queue_free()