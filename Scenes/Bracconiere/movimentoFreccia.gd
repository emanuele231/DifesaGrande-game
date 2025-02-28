extends Node2D

@export var speed: float = 300.0  # Velocità della freccia
@export var limite_x: float = 750.0  # Punto in cui eliminare la freccia

func _process(delta):
	position.x += speed * delta  # Muove la freccia

	if position.x > limite_x:  # Se supera il limite, viene distrutta
		queue_free()
