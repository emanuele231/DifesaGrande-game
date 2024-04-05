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

	
func _ready():
	$carta_rimasta.z_index = 3
	$plastica_rimasta.z_index = 3
	$indifferenziato_rimasto.z_index = 3
	$capienza_sacco.z_index = 3




		
	
	
