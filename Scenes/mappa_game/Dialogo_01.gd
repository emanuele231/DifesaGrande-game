extends Control

var dialog_sequence := [
	"Ciao! Sono Marienza, l'assessore del comune di Gravina.",
	"Ti do il benvenuto nel bosco Difesa Grande!",
	"Da qui la tua vita potrà ricominciare..",
	"..ed il tuo lavoro ci sarà di grande aiuto.",
	"Per iniziare ti consiglio di guardarti attorno,",
	"e una volta che ti sarai ambientato potrai svolgere il tuo primo compito.",
	"Utilizza la frecce direzionali per muoverti",
	"e cerca l'incendio per andare a spegnerlo!", # frase momentanea, per la sperimentazione della tesi - Angela Mileti
	"In bocca al lupo guardiano!"
]  

var current_dialog_index: int = -1
var player_script = preload("res://scripts/Player_prov_movements.gd")
var player = player_script.new()
var _on_dialog_complete_callback = null
var assessore_script = preload("res://Scenes/mappa_game/Assessore.gd")
var assessore = assessore_script.new()
var _assessore_callback = null
var _label_01_callback = null
signal dialogo_completato

var block: bool = false





func _ready():
	
	show_next_dialog()
	enable_player_movement()
	$indicazione.z_index = 3


	
func enable_player_movement():
	emit_signal("dialogo_completato")
	if _on_dialog_complete_callback != null and _assessore_callback != null and _label_01_callback != null:
		_on_dialog_complete_callback._on_dialog_complete()
		_assessore_callback._on_dialogo_completato()
		_label_01_callback._on_dialogo_completo()
		


		

func show_next_dialog() -> void:
	
	if current_dialog_index >= -1:
		current_dialog_index += 1
		
		if current_dialog_index < dialog_sequence.size():
			$Label.text = dialog_sequence[current_dialog_index]
			$Label.show()
			$Label.z_index = 2
			player.can_move = false
			assessore.can_move = false
		else:
			$Label.free()
			$indicazione.free()
			enable_player_movement()


func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton and event.is_pressed() or event is InputEventKey and event.is_pressed() and event.keycode == KEY_A:
		if current_dialog_index < dialog_sequence.size():
			show_next_dialog()
			if Input.is_joy_button_pressed(JOY_BUTTON_A,JOY_BUTTON_A):
				pass


