extends AnimationPlayer


var wave1 = preload("res://Scenes/Game/waves/wave_1.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _wave1() -> void:
	get_parent().add_child(wave1)
	
