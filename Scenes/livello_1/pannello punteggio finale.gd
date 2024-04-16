extends Control

func _ready():
	$Button.z_index = 3


func _on_button_button_down():
	var back_to_map = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	get_tree().change_scene_to_packed(back_to_map)
	var puntiOS = get_node("/root/PuntiSingleton")
	var puntiO = puntiOS.get_custom_puntiO()
	puntiO = 0
	puntiO = puntiOS.set_puntiO(puntiO)
	
	var puntiIS = get_node("/root/PuntiSingleton")
	var puntiI = puntiIS.get_custom_puntiI()
	puntiI = 0
	puntiI = puntiIS.set_puntiI(puntiI)
	
	var puntiPS = get_node("/root/PuntiSingleton")
	var puntiP = puntiPS.get_custom_puntiP()
	puntiP = 0
	puntiP = puntiPS.set_puntiP(puntiP)
	
	var puntiCS = get_node("/root/PuntiSingleton")
	var puntiC = puntiCS.get_custom_puntiC()
	puntiC = 0
	puntiC = puntiCS.set_puntiC(puntiC)
	
	var somma: int = 0
	$punti.text = str(somma)
