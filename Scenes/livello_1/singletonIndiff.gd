extends Node

var indiff : int = 0



func set_indiff(new_indiff: int):
	indiff = new_indiff

func get_custom_indiff(default: bool = false) -> int:
	return indiff
