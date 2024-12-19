extends CharacterBody3D


const SPEED = 0.1

# moves towards the player every frame
func _physics_process(delta: float) -> void:
	var target = get_node("/root/Game/Skater")
	
	velocity = target.get_position() - position
	
	velocity = velocity.normalized() * SPEED
	
	move_and_collide(velocity)
