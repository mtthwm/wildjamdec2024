extends AnimationPlayer


var wave1 = preload("res://Scenes/Game/waves/wave_1.tscn").instantiate()
var wave2 = preload("res://Scenes/Game/waves/wave_2.tscn").instantiate()
var wave3 = preload("res://Scenes/Game/waves/wave_3.tscn").instantiate()
var wave4 = preload("res://Scenes/Game/waves/wave_5.tscn").instantiate()
var wave5 = preload("res://Scenes/Game/waves/wave_5.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _wave1() -> void:
	get_parent().add_child(wave1)

func _wave2() -> void:
	get_parent().add_child(wave2)

func _wave3() -> void:
	get_parent().add_child(wave3)

func _wave4() -> void:
	get_parent().add_child(wave5)
	
func _wave5() -> void:
	get_parent().add_child(wave5)
