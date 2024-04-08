extends Node

var organico : int = 0



func set_organico(new_organico: int):
	organico = new_organico

func get_custom_organico(default: bool = false) -> int:
	return organico
