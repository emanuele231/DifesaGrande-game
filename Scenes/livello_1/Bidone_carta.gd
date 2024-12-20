extends Area2D
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

var puntiC: int = 0
var entered: bool = false
var stop1: bool = false

func _ready():
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".hide()
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".z_index = 2


func _on_body_entered(body: CharacterBody2D):
	entered = true
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".show()


func _on_body_exited(body):
	entered = false
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".hide()

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
	var c_sing = get_node("/root/SingletonCarta")
	var carta = c_sing.get_custom_carta()
	if carta > 0:
		stop1 = false
		carta = carta - 1
		var puntiC_sing = get_node("/root/PuntiSingleton")
		puntiC = puntiC_sing.get_custom_puntiC()
		puntiC += 3
		puntiC_sing.set_puntiC(puntiC)
		c_sing.set_carta(carta)
		
		$"../player/Camera2D/CanvasLayer/punteggi/carta_rimasta".text = str(carta)
	else:
		stop1 = true


