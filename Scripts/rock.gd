extends Node3D

@export
var initial_health:float
var current_health:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = initial_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_health <= 0:
		queue_free()
	


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("bullet"):
		current_health -= 10
