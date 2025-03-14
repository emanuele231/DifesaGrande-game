extends Control

##dialogo vandalo
var dialog_sequence := [
	"Oh no! Ecco chi stava infastidendo tutti!",
	"C'è un vandalo che si nasconde qui vicino",
	"Sta rovinando gli alberi di questa zona!",
	"Tocca a te fermarlo, guardiano.",
	"Trovalo, catturalo il prima possibile e caccialo via.",
	"Ma fai attezione, è molto veloce..",
	"Dovrai acciuffarlo entro 5 minuti,",
	"altrimenti riuscirà a scappare!",
	"Ricorda: utilizza le frecce direzionali per muoverti.",
	"Avvicinati a lui tenendo premuto il tasto 'A'",
	"Dovrai toccarlo con il tasto premuto, per acciuffarlo",
	"Contiamo tutti su di te! Forza!"
]  

var current_dialog_index: int = -1
var player_script_2 = preload("res://Scenes/livello_2_min_1/giocatore_2.gd")
var player_2 = player_script_2.new()
var _on_player_2_callback = null
var assessore_script_2 = preload("res://Scenes/livello_2_min_1/assessore_2.gd")
var assessore_2 = assessore_script_2.new()
var _assessore_2_callback = null
var punteggi_script = preload("res://Scenes/livello_1/punteggi.gd")
var punteggi = punteggi_script.new()
var _timer_callback = null
var _label_02_callback = null
signal spiegazione_chiusa


func _ready():
	
	show_next_dialog()
	enable_player_movement()


	
func enable_player_movement():
	emit_signal("spiegazione_chiusa")
	if _on_player_2_callback != null and _assessore_2_callback != null and _timer_callback != null:
		_on_player_2_callback._on_player_2()
		_assessore_2_callback._assessore_2()
		_timer_callback._timer()

		


		
##gestione dei dialoghi
func show_next_dialog() -> void:
	if $Label != null:
		if current_dialog_index >= -1:
			current_dialog_index += 1
		
			if current_dialog_index < dialog_sequence.size():
				$Label.text = dialog_sequence[current_dialog_index]
				$Label.show()
				$indicazione.show()
				$indicazione.z_index = 2
				$Label.z_index = 2
				player_2.can_move = false
				assessore_2.can_move = false
			else:
				$Label.free()
				$indicazione.hide()
				enable_player_movement()

	else:
		print("label vuoto")

##fa andare avanti il dialogo
func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton and event.is_pressed() or event is InputEventKey and event.is_pressed() and event.keycode == KEY_A:
		if current_dialog_index < dialog_sequence.size():
			show_next_dialog()
			if Input.is_joy_button_pressed(JOY_BUTTON_A,JOY_BUTTON_A):
				pass

	#if event is InputEventMouseButton and event.is_pressed():
		#if current_dialog_index < dialog_sequence.size():
			#show_next_dialog()
