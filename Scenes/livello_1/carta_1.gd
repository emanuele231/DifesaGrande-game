extends Area2D

var entered: bool = false
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
var current_capienza_index: int = 0
var index: int = 0
var carta = 0
var indifferenziato = 0
var organico = 0
var plastica = 0

var punteggi_script = preload("res://Scenes/livello_1/punteggi.gd")
var punteggi = punteggi_script.new()




func _on_body_entered(body: CharacterBody2D):
	entered = true

func _on_body_exited(body):
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			free()


'''
func update():
	if index < capienza_sequence.size():
		index += punteggi.update_label()
		print(index)
		if index < capienza_sequence.size():
			#$"../player/Camera2D/punteggi/capienza_sacco".text = capienza_sequence[index]
			#$"../player/Camera2D/punteggi/capienza_sacco".show()




func stampa():
	if index >= -1:
		index += 1
		print(index)
		if index < capienza_sequence.size():
			$"../player/Camera2D/punteggi/capienza_sacco".text = capienza_sequence[index]
			$"../player/Camera2D/punteggi/capienza_sacco".show()


func rifiuti():
	if $TileMap.is_in_group("carta"):
		$"../player/Camera2D/punteggi/carta_rimasta".text = carta + 1
	else:
		if $TileMap.is_in_group("plastica"):
			$"../player/Camera2D/punteggi/plastica_rimasta".text = plastica + 1
		else:
			if $TileMap.is_in_group("organico"):
				$"../player/Camera2D/punteggi/organico_rimasto".text = organico + 1
			else:
				if $TileMap.is_in_group("indifferenziata"):
					$"../player/Camera2D/punteggi/indifferenziato_rimasto".text = indifferenziato + 1
				else:
					if $TileMap.is_in_group("cass_carta"):
						capienza_sequence[current_capienza_index - 1]
						$"../Cassonetti/carta".text = carta - 1
					else:
						if $TileMap.is_in_group("cass_plastica"):
							capienza_sequence[current_capienza_index - 1]
							$"../Cassonetti/plastica".text = plastica - 1
						else:
							if $TileMap.is_in_group("cass_organico"):
								capienza_sequence[current_capienza_index - 1]
								$"../Cassonetti/organico".text = organico - 1
							else:
								if $TileMap.is_in_group("cass_indiff"):
									capienza_sequence[current_capienza_index - 1]
									$"../Cassonetti/indifferenziato".text = indifferenziato - 1

						
		

'''





