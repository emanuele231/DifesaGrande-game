extends Node

@onready var animation_player = $AnimationPlayer

var initial_scale: Vector2  
var initial_window_size: Vector2 

func _ready():
	initial_scale = self.scale  #scale originale
	initial_window_size = get_window().size  # salva la dimensione iniziale della finestra

	center_sprite()  # Centra lo sprite: necessario all'inizio e al resize perchè altrimenti le animazioni basate su offset non funzionano correttamente
	#get_window().size_changed.connect(_on_window_resized)

func center_sprite():
	await get_tree().process_frame
	var viewport_size = get_viewport().size
	self.position = viewport_size / 2
	print("Sprite centrato in:", self.position)

func _on_window_resized():
	center_sprite()
	var current_window_size = Vector2(get_window().size.x, get_window().size.y)
	var scale_factor = current_window_size / initial_window_size  
	self.scale = initial_scale * scale_factor 
	
#func _process(delta: float) -> void:
	#print("posizione", self.position)

func play_animation(state_name: String):
	if animation_player == null:
		print("Errore: AnimationPlayer non trovato!")
		return
	match state_name:
		"SelectState":
			animation_player.play("Idle")
		"ParlaState":
			animation_player.play("Idle")
		"DifesaState":
			animation_player.play("CamminaSX")
		"PunteggioState":
			animation_player.play("Idle")
