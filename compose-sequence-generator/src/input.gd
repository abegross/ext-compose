tool
extends VBoxContainer
signal text(text, name)

export(String, MULTILINE) var explanation setget _on_explanation
export(String) var input setget _on_input
onready var text = $hbox/input.text

func _on_explanation(new):
	explanation = new
	$label.bbcode_text = explanation

func _on_input(new):
	input = new
	$hbox/input.text = input
	$hbox/input.placeholder_text = input

func _ready() -> void:
	emit_signal("text", $hbox/input.text, name)
func _on_input_text_changed(new_text: String) -> void:
	text = new_text
	emit_signal("text", text, name)
