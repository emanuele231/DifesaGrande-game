extends Area2D


var entered: bool = true
@onready var tilemap = $TileMap1

func _on_body_entered(body: PhysicsBody2D):
	entered = true
	print(entered)



func _on_body_exited(body: PhysicsBody2D):
	entered = false
	print(entered)

func _process(delta):
	if entered == true and tilemap.is_in_group("carta_1"):
		if Input.is_key_label_pressed(KEY_C):
			free()
