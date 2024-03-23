extends Control

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
var current_capienza_index: int = -1




	
func _ready():
	update_label()
	$capienza_sacco.z_index = 3
	$carta_rimasta.z_index = 3
	$plastica_rimasta.z_index = 3
	$indifferenziato_rimasto.z_index = 3
	





func update_label():
	if capienza_sequence != null:
		if current_capienza_index >= -1:
			current_capienza_index += 1
			if current_capienza_index < capienza_sequence.size():
				$capienza_sacco.text = capienza_sequence[current_capienza_index]
				$capienza_sacco.show()
				$capienza_sacco.z_index = 3
	else:
		print("capienza sacco vuota")


	
	
