extends Button

var game = preload("res://Scenes/Game/game.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _button_pressed() -> void:
	get_parent().queue_free()
	get_tree().root.add_child(game)
