class_name InteractionProvider
extends Node3D

@export var target : Array[Node]
@export var doText : String
@export var undoText : String
@export var interact : Interactable

@export var playerProximityArea : Area3D
@export var interactionArea : Area3D

func do_interaction():
	pass

func config_interactable():
	interact.set_tooltip(doText)
	if !Engine.is_editor_hint():
		interact.playerProximityArea = playerProximityArea
		interactionArea.reparent(interact)
		interact.connect_to_areas()
		interact.set_tooltip(doText)
