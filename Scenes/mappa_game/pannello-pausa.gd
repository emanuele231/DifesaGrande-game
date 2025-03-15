extends Control

@onready var bottone_protezione = $protezione 
@onready var pausa = $"."  
var ripresa: bool = false
var protezione_panel_instance = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".z_index = 3
	var p_position = position
	
	bottone_protezione.pressed.connect(_on_protezione_button_down)

func _on_riprendi_button_down():
	ripresa = true
	pausa.hide()
	Engine.time_scale = 1
	
func _on_back_button_down():
	get_tree().quit()

func _on_protezione_button_down():
	if protezione_panel_instance == null:
		var protezione_scene = load("res://Scenes/Stats/stats_panel.tscn") 
		protezione_panel_instance = protezione_scene.instantiate() 
		protezione_panel_instance.z_index = 2
		add_child(protezione_panel_instance)  
		print("aggiunto menu achievement")
	else:
		protezione_panel_instance.visible = !protezione_panel_instance.visible
