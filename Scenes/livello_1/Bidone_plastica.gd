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


func _on_body_entered(body: CharacterBody2D):
	entered = true


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true and Input.is_key_label_pressed(KEY_S):
		assegna()
		if stop1 == false:
			svuota_sacco()

func svuota_sacco():
	var singleton = get_node("/root/Singleton")
	var sacco = singleton.get_custom_index()
	if sacco <= 10 and sacco > 0:
		sacco -= 1
		singleton.set_index(sacco)
		$"../player/Camera2D/punteggi/capienza_sacco".text = capienza[sacco]

func assegna():
	var p_sing = get_node("/root/SingletonPlastica")
	var plastica = p_sing.get_custom_plastica()
	if plastica > 0:
		stop1 = false
		plastica = plastica - 1
		p_sing.set_plastica(plastica)
		$"../player/Camera2D/punteggi/plastica_rimasta".text = str(plastica)
	else:
		stop1 = true
