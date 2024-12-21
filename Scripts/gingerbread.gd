extends CharacterBody3D


const SPEED = 0.1
var health = 3


func _ready() -> void:
	pass

# moves towards the player every frame
func _physics_process(delta: float) -> void:
	var skater = get_node("/root/Game/Skater")
	var target = skater.get_position()
	
	velocity = target - position
	
	velocity = velocity.normalized() * SPEED
	
	look_at(global_transform.origin + target, Vector3.UP)
	rotate_y(-PI/2) # the gingerbread model isn't forward by default
	
	var collision = move_and_collide(velocity)
	
	# check for a player to attack
	if collision is KinematicCollision3D:
		if collision.get_collider() == skater:
			skater._take_damage(1)
	

func _take_damage(damage: int) -> void:
	health = health - damage
	if health <= 0:
		queue_free()
