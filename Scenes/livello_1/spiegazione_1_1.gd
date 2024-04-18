extends Control

var dialog_sequence := [
	"Bene, qui inizia il tuo primo compito!",
	"Come puoi vedere la gente non ha interesse nel rispettare l'ambiente..",
	"Ora tocca a te!",
	"Dovrai raccogliere questi rifiuti entro 250 secondi",
	"Prima che arrivino i clienti del bar",
	"Come vedi hai una busta, che può contenere un massimo di 10 rifiuti",
	"Per raccoglierli, ti basta avvicinarti ad essi e premere 'A'",
	"Le icone a destra di diranno che tipo di rifiuto hai raccolto",
	"Quando la tua busta sarà piena, recati ai bidoni della spazzatura",
	"Lì, potrai gettare i rifiuti nei rispettivi cassonetti premendo 'B'",
	"Allo scadere del tempo, il sindaco comunicherà il tuo punteggio",
	"In bocca al lupo! E ricorda di differenziare!"
]  

var current_dialog_index: int = -1
var player_script_1 = preload("res://Scenes/livello_1/giocatore-lvl-1.gd")
var player_1 = player_script_1.new()
var _on_player_1_callback = null
var assessore_script_1 = preload("res://Scenes/livello_1/assessore_1_1.gd")
var assessore_1 = assessore_script_1.new()
var _assessore_1_callback = null
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
	if _on_player_1_callback != null and _assessore_1_callback != null and _timer_callback != null: #and _label_02_callback != null:
		_on_player_1_callback._on_player_1()
		_assessore_1_callback._assessore_1()
		_timer_callback._timer()
		#_label_02_callback._on_dialogo_completo()
		


		

func show_next_dialog() -> void:
	if $Label != null:
		if current_dialog_index >= -1:
			current_dialog_index += 1
		
			if current_dialog_index < dialog_sequence.size():
				$Label.text = dialog_sequence[current_dialog_index]
				$Label.show()
				$Label.z_index = 2
				player_1.can_move = false
				assessore_1.can_move = false
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
