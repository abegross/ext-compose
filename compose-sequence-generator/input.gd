tool
extends VBoxContainer
signal text(text, name)

export(String, MULTILINE) var explanation setget _on_explanation
export(String) var input setget _on_input
onready var text = $input.text

func _on_explanation(new):
	explanation = new
	$label.text = explanation

func _on_input(new):
	input = new
	$input.text = input
	$input.placeholder_text = input

#func _ready() -> void:
#	$input.connect("text_entered", self, "_text_entered")
#	$input.emit_signal("text_entered")
#
#func _text_entered(text):
#	emit_signal("text", text, name)

func _on_input_text_changed(new_text: String) -> void:
	text = new_text
