extends Control

var dialog_sequence := [
	"Benvenuto nel bosco Difesa Grande!",
	"Da qui, inizia la tua avventura!",
	"In ogni zona, ci saranno dei lavori da svolgere per ripulirla",
	"Controlla la tua mappa, li ci saranno le esatte posizioni dei lavori",
	"in bocca al lupo"
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






func _ready():
	
	show_next_dialog()
	enable_player_movement()


	
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
			enable_player_movement()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if current_dialog_index < dialog_sequence.size():
			show_next_dialog()