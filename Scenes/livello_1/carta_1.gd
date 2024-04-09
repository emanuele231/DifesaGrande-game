extends Area2D

var entered: bool = false
var stop: bool = true
var capienza_sequence := [
	"0/10",
	"1/10",
	"2/10",
	"3/10",
	"4/10",
	"5/10",
	"6/10",
	"7/10",
	"8/10",
	"9/10",
	"10/10"
]



func _on_body_entered(body: CharacterBody2D):
	entered = true

	

func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			set_catch()
			if stop == true:
				free()


func set_catch():
	var singleton = get_node("/root/Singleton")
	var index = singleton.get_custom_index()
	index += 1
	if index < capienza_sequence.size():
		stop = true
		singleton.set_index(index)
		$"../player/Camera2D/punteggi/capienza_sacco".text = capienza_sequence[index]
		$"../player/Camera2D/punteggi/capienza_sacco".show()
	else:
		stop = false





