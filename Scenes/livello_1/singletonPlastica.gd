extends Node

var plastica : int = 0



func set_plastica(new_plastica: int):
	plastica = new_plastica

func get_custom_plastica(default: bool = false) -> int:
	return plastica
