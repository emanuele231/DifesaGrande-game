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
var puntiI: int = 0
var stop1: bool = false


func _on_body_entered(body: CharacterBody2D):
	entered = true




func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true and Input.is_joy_button_pressed(JOY_BUTTON_A,JOY_BUTTON_B) or Input.is_action_just_pressed("ui_accept"):
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
	var i_sing = get_node("/root/SingletonIndiff")
	var indiff = i_sing.get_custom_indiff()
	if indiff > 0:
		stop1 = false
		indiff = indiff - 1
		var puntiI_sing = get_node("/root/PuntiSingleton")
		puntiI = puntiI_sing.get_custom_puntiI()
		puntiI += 4
		puntiI_sing.set_puntiI(puntiI)
		i_sing.set_indiff(indiff)
		$"../player/Camera2D/CanvasLayer/punteggi/capienza_sacco".text = str(indiff)
	else:
		stop1 = true
