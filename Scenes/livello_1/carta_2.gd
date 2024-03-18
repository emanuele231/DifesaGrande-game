extends Area2D


var entered: bool = true
@onready var tilemap = $TileMap
@onready var area = $"."
@onready var contatto = $CollisionShape2D

func _on_body_entered(body: PhysicsBody2D):
	entered = true



func _on_body_exited(body: PhysicsBody2D):
	entered = false

func _process(delta):
	if entered == true and tilemap.is_in_group("carta_2") and area.is_in_group("carta_02"):
		if Input.is_key_label_pressed(KEY_C):
			free()
