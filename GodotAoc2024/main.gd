extends Node

var day = 1
var year = 2023

func _ready():
	var http = $HTTPRequest
	http.request_completed.connect(_on_request_completed)
	
	var url = getUrl(year, day)
	var session = getSession()
	var headers = ["Content-Type: text/plain", "Cookie: session=" + session]
	http.request(url, headers, HTTPClient.METHOD_GET)

func getSession():
	var file = FileAccess.open("res://secret.txt", FileAccess.READ)
	var session = file.get_as_text().strip_edges()
	return session

func getUrl(y, d):
	return "https://adventofcode.com/" + str(y) + "/day/" + str(d) +"/input"

func _on_request_completed(result, response_code, headers, body):
	var dir = DirAccess.open("res://day")
	if not dir.dir_exists(str(day)):
		dir.make_dir(str(day))
	
	var file = FileAccess.open("res://day/" + str(day) + "/input.txt", FileAccess.WRITE)
	file.store_string(body.get_string_from_utf8())
