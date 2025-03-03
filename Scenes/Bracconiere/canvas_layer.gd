extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size = get_viewport_rect().size
	$Sprite2D.position = viewport_size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
