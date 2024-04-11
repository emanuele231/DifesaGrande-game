extends Node

var puntiC : int = 0
var puntiI : int = 0
var puntiP : int = 0
var puntiO : int = 0


func set_puntiC(new_puntiC: int):
	puntiC = new_puntiC

func get_custom_puntiC(default: bool = false) -> int:
	return puntiC


func set_puntiI(new_puntiI: int):
	puntiI = new_puntiI

func get_custom_puntiI(default: bool = false) -> int:
	return puntiI


func set_puntiP(new_puntiP: int):
	puntiP = new_puntiP

func get_custom_puntiP(default: bool = false) -> int:
	return puntiP


func set_puntiO(new_puntiO: int):
	puntiO = new_puntiO

func get_custom_puntiO(default: bool = false) -> int:
	return puntiO
