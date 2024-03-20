extends Control

var count = 0
var capienza_sacco

func _ready():
	capienza_sacco = $capienza_sacco
	$capienza_sacco.z_index = 3
	$carta_rimasta.z_index = 3
	$plastica_rimasta.z_index = 3
	$organico_rimasto.z_index = 3
	$indifferenziato_rimasto.z_index = 3
	if capienza_sacco != null:
		update_label()
	else:
		print("problemi con il label")

func update_label():
	
