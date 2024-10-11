extends Control

var pausa_script = preload("res://Scenes/livello_1/pausa.gd")
var pausa = pausa_script.new()
@onready var pannello_pausa = $"."
var riprendi: bool = false

func _input(event: InputEvent) -> void:
			if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_B):
				_on_riprendi_button_down()
			elif Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_Y)and pausa.paused == true:
				_on_riavvia_button_down()
			elif Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_X)and pausa.paused == true:
				_on_back_button_down()

func _ready():
	$".".z_index = 3
	$Label.z_index = 3
	$riprendi.z_index = 3
	$riavvia.z_index = 3
	$back.z_index = 3
	
	

func _on_riprendi_button_down():
	riprendi = true
	pannello_pausa.hide()
	Engine.time_scale = 1


func _on_riavvia_button_down():
	get_tree().reload_current_scene()
	
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
	$"../punteggio/punti".text = str(somma)


func _on_back_button_down():
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

	var back = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	get_tree().change_scene_to_packed(back)
	
