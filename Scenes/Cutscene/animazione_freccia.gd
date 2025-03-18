extends Node

# Nome dell'animazione che desideri far partire automaticamente
var animation_name = "freccia_idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Avvia l'animazione automaticamente
	$AnimationPlayer.play(animation_name)
