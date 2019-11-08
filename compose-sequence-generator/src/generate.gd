extends Button

signal result(result)

var composed: String
var regular
var sequence: String

func _pressed() -> void:
	var output = []

	OS.execute('python', ["compose-sequence-generator.py", regular, composed, sequence], true, output)

	output = output[0].lstrip("b'").rstrip("'") # strip b' and ' at both ends
	output = Marshalls.base64_to_utf8(output) # convert to Unicode
	print(output)

	emit_signal("result", output)


func _on_text_entered(text: String, name: String) -> void:
	match name:
		"composed": composed = text
		"regular": regular = text# "'"+"'"+var2str(Array(text.split(","))).replace('"', "'")+"'"
		"sequence": sequence = text

	_pressed()

