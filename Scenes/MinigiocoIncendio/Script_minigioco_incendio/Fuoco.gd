extends Node2D

# Definizione dei vari tipi di fuoco
enum FireType {SMALL, MEDIUM, LARGE}

# Variabili per il tipo di fuoco e per lo scaling
var fire_type = FireType.SMALL #default
var fire_sprite: AnimatedSprite2D

# Scaling dei diversi tipi di fuoco
var fire_scales = {
	FireType.SMALL: Vector2(15, 15),
	FireType.MEDIUM: Vector2(7, 7),
	FireType.LARGE: Vector2(9, 9)
}

# Called when the node enters the scene tree for the first time.
func _ready():
	fire_sprite= $Fuoco
	fire_sprite.play("idle_fire")
	set_fire_type(fire_type)


# Funzione per impostare il tipo di fuoco e il suo scaling
func set_fire_type(type):
	fire_type= type
	fire_sprite.scale = fire_scales[fire_type]
