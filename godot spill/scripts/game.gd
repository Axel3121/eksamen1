extends Node

const API_URL = "http://127.0.0.1:5000/api/highscore"

# Kall denne når spillet er over
func lagre_highscore(spillernavn: String, poeng: int, tid: float):
	print("Prøver å lagre highscore...")
	var http = HTTPRequest.new()
	add_child(http)
	http.set_meta("keep_alive", true)  # ← legg til denne
	
	var body = JSON.stringify({
		"spillernavn": spillernavn,
		"poeng": poeng,
		"tid": tid
	})
	print("Sender: ", body)
	var headers = ["Content-Type: application/json"]
	var feil = http.request(API_URL, headers, HTTPClient.METHOD_POST, body)
	print("Request feilkode: ", feil)
	await http.request_completed
	print("Highscore lagret!")

# Hent topp 10
func hent_highscore():
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_highscore_mottatt)
	http.request(API_URL)

func _highscore_mottatt(result, response_code, headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	for rad in data:
		print(rad["spillernavn"], " - ", rad["poeng"], " poeng - ", rad["tid"], "s")
