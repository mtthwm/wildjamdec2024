extends Node3D

const SPEED = 20
const POWER = 1
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var ray: RayCast3D = $RayCast3D
@onready var timer: Timer = $Timer
@onready var particles: GPUParticles3D = $GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.connect("timeout",queue_free)
	timer.set_wait_time(1)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta

	var body = $RigidBody3D
	var collision = body.move_and_collide(Vector3(0,0,0))
	if collision is KinematicCollision3D:
		mesh.visible = false
		particles.emitting = true
		collision.get_collider()._take_damage(POWER)
		body.process_mode = Node.PROCESS_MODE_DISABLED 
		await get_tree().create_timer(1.0).timeout
		queue_free()
	
