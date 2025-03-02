# DifesaState.gd
extends State

@onready var playerBar = get_parent().get_parent().get_node("PlayerBar")
@onready var bracconiereBar = get_parent().get_parent().get_node("Sprite2D/ConvinzioneBracconiere")
@onready var bracconiere = get_parent().get_parent().get_node("Sprite2D")
@onready var difesaUI = get_parent().get_parent().get_node("DifesaUI")
@onready var sfondoMinigioco = get_parent().get_parent().get_node("DifesaUI/SfondoMinigioco")
@onready var animationPlayer = get_parent().get_parent().get_node("Sprite2D/AnimationPlayer")
@onready var playerBarLabel = get_parent().get_parent().get_node("PlayerBar/Label")

var minigioco_instance = null
const MINIGIOCO_PATH = "res://Scenes/Bracconiere/minigiocoFrecce.tscn"

func enter():
	difesaUI.visible = true
	sfondoMinigioco.visible = false
	bracconiereBar.visible = false
	playerBar.visible = true
	
	await animationPlayer.animation_finished  # Aspetta la fine dell'animazione precedente
	
	sfondoMinigioco.visible = true
	precarica_minigioco()
	avvia_minigioco()
	
func precarica_minigioco():
	var minigioco_scene = load(MINIGIOCO_PATH)
	if minigioco_scene:
		minigioco_instance = minigioco_scene.instantiate()
		minigioco_instance.visible = false  # Nasconde il minigioco finché non viene avviato
		minigioco_instance.vita_ridotta.connect(_on_vita_ridotta)
		minigioco_instance.minigioco_terminato.connect(_on_minigioco_terminato)
		sfondoMinigioco.add_child(minigioco_instance)
	else:
		push_error("Errore: impossibile caricare il minigioco!")
		_on_minigioco_terminato(false)  # Se il caricamento fallisce, termina il minigioco

func avvia_minigioco():
	if minigioco_instance:
		minigioco_instance.visible = true  # Rendi visibile il minigioco precaricato
		animationPlayer.play("Spara")  # Avvia l'animazione "Spara"
	else:
		push_error("Errore: Minigioco non precaricato!")

func _on_vita_ridotta(danno):
	PunteggioBracconiere.rimuovi_punti(danno)
	print("Vita ridotta di:", danno)  # Debug
	playerBar.value = max(playerBar.value - danno, 0)  # Evita valori negativi
	playerBarLabel.text = str(playerBar.value) + "%"  # Aggiorna il testo
	
	await get_tree().create_timer(0.05).timeout
	
	if playerBar.value <= 0:
		termina_minigioco()
		playerBar.visible = false
		get_parent().transition_to("PunteggioState")

func _on_minigioco_terminato(successo):
	termina_minigioco()
	get_parent().transition_to("SelectState")

func termina_minigioco():
	if minigioco_instance:
		minigioco_instance.queue_free()
		minigioco_instance = null

func exit():
	termina_minigioco()
	bracconiereBar.visible = true
	difesaUI.visible = false
	sfondoMinigioco.visible = false
