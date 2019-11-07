extends Button

var regular: String
var composed: String
var sequence: String

var result: String


#func _ready() -> void:
#	$"../../right/output".text = "我が名を知るが良い"

func _pressed() -> void:
	regular = $"../regular".text
	composed = $"../composed".text
	sequence = $"../sequence".text

	var output = []
	print("vars: ",regular, composed, sequence)

	OS.execute("python", ["compose-sequence-generator.py", regular, composed, sequence], true, output)
	output = output[0].lstrip("b'").rstrip("'") # strip b' and ' at both ends
	output = Marshalls.base64_to_utf8(output) # convert to Unicode

	$"../../right/output".text = output



#
#func _on_regular_text_changed(new_text: String) -> void:
#	regular = new_text
#
#func _on_composed_text_changed(new_text: String) -> void:
#	composed = new_text
#
#func _on_sequence_text_changed(new_text: String) -> void:
#	sequence = new_text


func _on_text_entered(text: String, name: String) -> void:
	match name:
		"composed": composed = text
		"regular": regular = text
		"sequence": sequence = text

	_pressed()