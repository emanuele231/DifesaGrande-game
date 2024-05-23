extends Area2D


var entered: bool = false
var capienza := [
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

var stop1: bool = false
var puntiO: int = 0
func _on_body_entered(body: CharacterBody2D):
	entered = true


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true and Input.is_key_label_pressed(KEY_C):
		assegna()
		if stop1 == false:
			svuota_sacco()

func svuota_sacco():
	var singleton = get_node("/root/Singleton")
	var sacco = singleton.get_custom_index()
	if sacco <= 10 and sacco > 0:
		sacco -= 1
		singleton.set_index(sacco)
		$"../player/Camera2D/CanvasLayer/punteggi/capienza_sacco".text = capienza[sacco]

func assegna():
	var o_sing = get_node("/root/SingletonOrganico")
	var organico = o_sing.get_custom_organico()
	if organico > 0:
		stop1 = false
		organico = organico - 1
		var puntiO_sing = get_node("/root/PuntiSingleton")
		puntiO = puntiO_sing.get_custom_puntiO()
		puntiO += 2
		puntiO_sing.set_puntiO(puntiO)
		o_sing.set_organico(organico)
		$"../player/Camera2D/CanvasLayer/punteggi/organico_rimasto".text = str(organico)
	else:
		stop1 = true
