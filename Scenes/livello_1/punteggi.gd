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
var index: int = -1

var item_script = preload("res://Scenes/livello_1/carta_1.gd")
var item = item_script.new()

	
func _ready():
	$carta_rimasta.z_index = 3
	$plastica_rimasta.z_index = 3
	$indifferenziato_rimasto.z_index = 3
	$capienza_sacco.z_index = 3
	show_label()

func _process(delta):
		show_label()

func incrementa() -> int:
	index += 1
	print(index)
	return index

func show_label():
	if item.catch == true:
		index = incrementa()
		print(index)
		$capienza_sacco.text = capienza_sequence[index]
		$capienza_sacco.show()



		
	
	
