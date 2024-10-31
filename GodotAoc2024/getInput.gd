@tool

extends EditorScript

var day: int = 1

func _ready():
	pass

func _run():
	var main = get_scene()
	var http = main.get_node("HTTPRequest")
	print(http)
