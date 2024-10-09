extends Control

var dialog_sequence := [
	"Oh no! Ecco chi stava infastidendo tutti!",
	"Quel vandalo sta rovinando gli alberi di questa zona!",
	"Ora tocca a te fermarlo",
	"Dovrai catturarlo subito e cacciarlo via",
	"Ma attento è molto veloce",
	"Dovrai cercare di acchiapparlo entro 5 minuti",
	"Altrimenti riuscirà a scappare!",
	"Ricorda! Utilizza le frecce direzionali per muoverti",
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

		


		

func show_next_dialog() -> void:
	if $Label != null:
		if current_dialog_index >= -1:
			current_dialog_index += 1
		
			if current_dialog_index < dialog_sequence.size():
				$Label.text = dialog_sequence[current_dialog_index]
				$Label.show()
				$Label.z_index = 2
				player_2.can_move = false
				assessore_2.can_move = false
			else:
				$Label.free()
				enable_player_movement()

	else:
		print("label vuoto")


func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton and event.is_pressed() or event is InputEventMouseButton and event.is_pressed():
		if current_dialog_index < dialog_sequence.size():
			show_next_dialog()
			if Input.is_joy_button_pressed(JOY_BUTTON_A,JOY_BUTTON_A):
				pass

	#if event is InputEventMouseButton and event.is_pressed():
		#if current_dialog_index < dialog_sequence.size():
			#show_next_dialog()
