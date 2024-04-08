extends Node

var carta : int = 0



func set_carta(new_carta: int):
	carta = new_carta

func get_custom_carta(default: bool = false) -> int:
	return carta
