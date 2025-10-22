@tool
class_name Interactable
extends Node3D

signal player_entered(player:Node3D)
signal player_exited(player:Node3D)
signal interacted(interactionSource : Node3D)

@export var playerProximityArea : Area3D
#@export var interactArea : Area3D

@onready var tooltiptext : Label3D = %tooltiptext

func connect_to_areas() -> void:
	playerProximityArea.connect("body_entered", _on_player_proximity_area_body_entered)
	playerProximityArea.connect("body_exited", _on_player_proximity_area_body_exited)
 	
func set_tooltip(text : String):
	tooltiptext.text = text

func interact(interactionSource : CharacterBody3D) -> void:
	interacted.emit(interactionSource)

var _should_tooltip := true

func enable_tooltip() -> void:
	_should_tooltip =true

func disable_tooltip() -> void:
	_should_tooltip = false

func _on_player_proximity_area_body_entered(body:Node3D) -> void:
	if body is CharacterBody3D:
		player_entered.emit(body)
		if _should_tooltip:
			tooltiptext.show()

func _on_player_proximity_area_body_exited(body:Node3D) -> void:
	if body is CharacterBody3D:
		player_exited.emit(body)
		if _should_tooltip:
			tooltiptext.hide()
