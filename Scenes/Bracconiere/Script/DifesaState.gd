extends State

@onready var playerBar = get_parent().get_parent().get_node("UI/PlayerBar")
@onready var bracconiereBar = get_parent().get_parent().get_node("UI/ConvinzioneBracconiere")
@onready var difesaUI = get_parent().get_parent().get_node("UI/DifesaUI")
@onready var sfondoMinigioco = get_parent().get_parent().get_node("UI/DifesaUI/SfondoMinigioco")
@onready var animationPlayer = get_parent().get_parent().get_node("Sprite2D/AnimationPlayer")
@onready var playerBarLabel = get_parent().get_parent().get_node("UI/PlayerBar/Label")
@onready var audioPlayer = get_parent().get_parent().get_node("Effetti")  # Aggiunto per il suono

var minigioco_instance = null
const MINIGIOCO_PATH = "res://Scenes/Bracconiere/minigiocoFrecce.tscn"

var initial_window_size = null
var initial_minigioco_scale = null
var small_screen_x = 30
var small_screen_y = 60
var full_screen_x = 45
var full_screen_y = 70

func _ready():
	initial_window_size = Vector2(get_window().size)
	#get_window().size_changed.connect(_on_window_resized)

func enter():
	difesaUI.visible = true
	sfondoMinigioco.visible = false
	bracconiereBar.visible = false
	playerBar.visible = true
	
	await animationPlayer.animation_finished  

	sfondoMinigioco.visible = true
	precarica_minigioco()
	avvia_minigioco()

func precarica_minigioco():
	var minigioco_scene = load(MINIGIOCO_PATH)
	if minigioco_scene:
		minigioco_instance = minigioco_scene.instantiate()
		sfondoMinigioco.add_child(minigioco_instance)

		# scale iniziale
		#initial_minigioco_scale = minigioco_instance.scale

		#_on_window_resized()

		minigioco_instance.visible = false 
		minigioco_instance.vita_ridotta.connect(_on_vita_ridotta)
		minigioco_instance.minigioco_terminato.connect(_on_minigioco_terminato)
	else:
		push_error("Errore: impossibile caricare il minigioco!")
		_on_minigioco_terminato(false)  

func avvia_minigioco():
	if minigioco_instance:
		minigioco_instance.visible = true  
		animationPlayer.play("Spara")  
	else:
		push_error("Errore: Minigioco non precaricato!")

func _on_window_resized():
	if not minigioco_instance:
		return
	
	print("window size",Vector2(get_window().size))
	var current_window_size = Vector2(get_window().size)
	
	if current_window_size == Vector2(1280, 720): #soluzione provvisoria
		minigioco_instance.position = Vector2(small_screen_x,small_screen_y)
	else:
		minigioco_instance.position = Vector2(full_screen_x,full_screen_y)
		
	var scale_factor = current_window_size / initial_window_size  

	minigioco_instance.scale = initial_minigioco_scale * scale_factor

func _on_vita_ridotta(danno):
	PunteggioBracconiere.rimuovi_punti(danno)
	print("Vita ridotta di:", danno)  
	playerBar.value = max(playerBar.value - danno, 0)  
	playerBarLabel.text = str(playerBar.value) + "%"  
	
	await get_tree().create_timer(0.05).timeout
	
	if playerBar.value <= 0:
		audioPlayer.stream = load("res://Scenes/Bracconiere/Sound Effects/game-over-39-199830.mp3")  # Carica il suono
		audioPlayer.play()  # Riproduce il suono di game over
		termina_minigioco()
		playerBar.visible = false
		bracconiereBar.visible = false
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
