extends Node

var index : int = 0



func set_index(new_index: int):
	index = new_index

func get_custom_index(default: bool = false) -> int:
	return index
