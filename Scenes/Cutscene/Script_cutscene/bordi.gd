extends Polygon2D

var hover = false
var border_color = Color(1, 1, 0)  # Colore del bordo brillante (giallo)
var transition_speed = 5.0  # Velocita di transizione del colore (piu' alto = piu' veloce)


# Funzione chiamata ad ogni frame.
func _process(delta: float):
	hover = is_mouse_over()

	if hover:
		modulate= Color(
			lerp(modulate.r, border_color.r, transition_speed * delta),
			lerp(modulate.g, border_color.g, transition_speed * delta),
			lerp(modulate.b, border_color.b, transition_speed * delta),
			lerp(modulate.a, border_color.a, transition_speed * delta)
		)
	else:
		modulate = Color(
			lerp(modulate.r, color.r, transition_speed * delta),
			lerp(modulate.g, color.g, transition_speed * delta),
			lerp(modulate.b, color.b, transition_speed * delta),
			lerp(modulate.a, color.a, transition_speed * delta)
		)


# Funzione per verificare se il mouse e' sopra il poligono
func is_mouse_over():
	var mouse_pos = get_viewport().get_mouse_position()
	return is_point_in_polygon(mouse_pos, get_polygon())


# Funzione che determina se un punto e' dentro un poligono (algoritmo ray-casting)
func is_point_in_polygon(point: Vector2, polygon: Array):
	var inside = false
	var n = polygon.size()
	var j = n - 1
	for i in range(n):
		var vi = polygon[i]
		var vj = polygon[j]
		if ((vi.y > point.y) != (vj.y > point.y)) and (point.x < (vj.x - vi.x) * (point.y - vi.y) / (vj.y - vi.y) + vi.x):
			inside = !inside
		j = i
	return inside
