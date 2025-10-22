@tool
class_name ScriptInteractionProvider
extends InteractionProvider

@export var executable : Script

func _ready() -> void:
	interact.connect("interacted", execute)
	config_interactable()

func execute(_source : Node3D):
	executable.call("execute", get_tree())