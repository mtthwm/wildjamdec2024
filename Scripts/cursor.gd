extends CharacterBody3D

@onready var aim: MeshInstance3D = $aim
@onready var cursor: MeshInstance3D = $cursor
@onready var playergun: RayCast3D = $"RayCast3D"
@onready var camera: Camera3D = $"../../Camera3D2"

var bullet = load("res://Scenes/Game/bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at_cursor()

	
func look_at_cursor():
	var player_pos = global_transform.origin
	var dropPlane = Plane(Vector3(0, 1, 0), player_pos.y)
	
	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos = dropPlane.intersects_ray(from,to)
	
	cursor.global_transform.origin = cursor_pos + Vector3(0, 1, 0)
	
	look_at(cursor_pos, Vector3.UP)
