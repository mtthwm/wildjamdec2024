extends CharacterBody3D


var SPEED
var health
@export var baby = false
@export var boss = false


func _ready() -> void:
	if baby == true:
		SPEED = 0.15
		health = 1
	elif boss == true:
		SPEED = 0.11
		health = 50
	else:
		SPEED = 0.1
		health = 1

# moves towards the player every frame
func _physics_process(delta: float) -> void:
	var skater = get_node("/root/Game/Skater")
	var target = skater.get_position()
	
	velocity = target - position
	velocity = velocity.normalized() * SPEED
	look_at(target, Vector3.UP)
	rotate_y(-PI/2) # the model isn't forward by default
	
	var collision = move_and_collide(velocity)
	
	# check for a player to attack
	if collision is KinematicCollision3D:
		if collision.get_collider() == skater:
			skater._take_damage(1)
	

func _take_damage(damage: int) -> void:
	health = health - damage
	if health <= 0:
		queue_free()
	
