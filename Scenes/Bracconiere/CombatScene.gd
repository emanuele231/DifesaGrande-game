extends Node2D

#func _ready():
	#connect("tree_entered", self, "_on_tree_entered")
	#connect("tree_exited", self, "_on_tree_exited")

func _on_tree_entered():
	print("Nodo entrato: Imposto lo stretch mode a 'viewport'")
	ProjectSettings.set_setting("display/window/stretch/mode", "viewport")
	ProjectSettings.save()

func _on_tree_exited():
	print("Nodo uscito: Imposto lo stretch mode a 'disabled'")
	ProjectSettings.set_setting("display/window/stretch/mode", "disabled")
	ProjectSettings.save()
