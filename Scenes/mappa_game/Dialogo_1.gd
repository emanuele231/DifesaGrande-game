extends Control


# Proprietà del dialogo
var dialog_sequence := [
	"Benvenuto nel bosco Difesa Grande!",
	"Da qui, inizia la tua avventura!",
	"In ogni zona, ci saranno dei lavori da svolgere per ripulirla",
	"Controlla la tua mappa, li ci saranno le esatte posizioni dei lavori",
	"in bocca al lupo"
]  

var is_dialog_active: bool = false
var current_dialog_index: int = -1
var player_script = preload("res://scripts/Player_prov_movements.gd")
var player = player_script.new()

func _ready():
	show_next_dialog()


func show_next_dialog() -> void:
	is_dialog_active = true
	
	if current_dialog_index >= -1:
		current_dialog_index += 1
		
		if current_dialog_index < dialog_sequence.size():
			$Label.text = dialog_sequence[current_dialog_index]
			$Label.show()
			player.can_move = false
		else:
			player.can_move = true
			$Label.free()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and is_dialog_active:
		if current_dialog_index < dialog_sequence.size():
			show_next_dialog()


