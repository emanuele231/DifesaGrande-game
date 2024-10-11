extends CharacterBody2D

var dialog_01_sequence := [
	"Ehi, Guardiano! Hai ripulito il bar? Sei stato fantastico!",
	"Adesso il bar Quercus è pulito e si vede già la differenza.",
	"Ti do il benvenuto ora nella ZONA DELLE LEPRI.",
	"Come vedi, è pieno di lepri che gironzolano quà e là.",
	"Ma qualcosa le sta minacciando..",
	"Trova il punto esclamativo ( ! ) bianco più avanti sulla strada,",
	"e scopri cosa minaccia queste creature!"
]
const SPEED = 70
var can_move: bool = false
var can_talk: bool = false
var dialogo_script = preload("res://Scenes/mappa_game/Dialogo_02.gd")
var dialogo = dialogo_script.new()
var current_dialog_index: int = -1
@onready var dialog_label = $Dialogo_02/Label_02
@onready var dialog_indication = $Dialogo_02/indicazione
@onready var assessore_label = $Dialogo_02/Label_A
@onready var anim_ass = $Sprite2D/AnimationTree
@onready var animazione = anim_ass.get("parameters/playback")

func _ready():
	dialog_label.hide()
	dialog_label.z_index = 3
	dialog_indication.hide()
	dialog_indication.z_index = 3
	


func _assessore_2():
	can_move = true

func _physics_process(_delta):
	move(_delta)
	
func move(_delta):
	if can_move == true:
		var new_position = position + Vector2.DOWN * SPEED * _delta
		anim_ass.set("parameters/walk/blend_position", new_position)
		animazione.travel("walk")
		position = new_position


func _on_area_2d_body_entered(body: CharacterBody2D):
	can_talk = true
	print("Posso parlare!")

func _on_area_2d_body_exited(body: CharacterBody2D):
	can_talk = false

func _input(event: InputEvent):
	if can_talk == true and event is InputEventKey and event.is_pressed() and event.keycode == KEY_A:
		now_you_can_talk()

func now_you_can_talk():
	dialog_label.show()

	if current_dialog_index >= -1:
		current_dialog_index += 1
		
		if current_dialog_index < dialog_01_sequence.size():
			if dialog_label:
				dialog_label.show()
				dialog_indication.show()
				dialog_label.text = dialog_01_sequence[current_dialog_index]
				dialog_label.z_index = 2
		else:
			if dialog_label:
				dialog_label.free()
				dialog_indication.free()
				assessore_label.free()
				$Area2D.free()
				can_move = true
			current_dialog_index = -1
