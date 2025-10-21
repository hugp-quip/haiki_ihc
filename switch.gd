class_name Switch
extends MeshInstance3D

@export var target : Array[Node]
@export var switch_text1 : String
@export var switch_text2 : String

func switch():
	pass

func _switch_tooltiptext():
	if %tooltiptext.text == switch_text1:
		%tooltiptext.text = switch_text2
	else:
		%tooltiptext.text = switch_text1