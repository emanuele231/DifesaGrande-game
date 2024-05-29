extends Control


var dialog_01_sequence := [
	"Sei stato fantastico!!",
	"Adesso il bar Quercus è stato ripulito",
	"Benvenuto ora nella ZONA DELLE LEPRI",
	"Come vedi, è pieno di lepri che gironzolano qua e la",
	"Ma qualcosa le sta minacciando",
	"Trova il punto esclamativo ( !!! ) bianco sulla strada",
	"scopri che cosa minaccia queste creature!"
] 


var current_dialog_index: int = -1
var player_script = preload("res://scripts/Player_prov_movements.gd")
var player = player_script.new()
var assessore_script = preload("res://Scenes/mappa_game/assessore-lvl-2.gd")
var assessore = assessore_script.new()
var _on_dialog_complete_callback = null
var _assessore_2_callback = null
var _label_01_callback = null
signal dialogo_completato

var block: bool = false
		
	
func enable_player_movement():
	emit_signal("dialogo_completato")
	if _on_dialog_complete_callback != null and _assessore_2_callback != null and _label_01_callback != null:
		_on_dialog_complete_callback._on_dialog_complete()
		_assessore_2_callback._on_dialogo_completato()
		_label_01_callback._on_dialogo_completo()
		


		

func show_next_dialog() -> void:
		$Label_02.show()
		if current_dialog_index >= -1:
			current_dialog_index += 1
		
			if current_dialog_index < dialog_01_sequence.size():
				$Label_02.text = dialog_01_sequence[current_dialog_index]
				$Label_02.show()
				$Label_02.z_index = 2
				player.can_move = false
			else:
				$Label_02.free()
				enable_player_movement()



func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton and event.is_pressed() or event is InputEventMouseButton and event.is_pressed():
		if current_dialog_index < dialog_01_sequence.size():
			show_next_dialog()
			if Input.is_joy_button_pressed(JOY_BUTTON_A,JOY_BUTTON_A):
				pass


