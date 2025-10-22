class_name GlobalUtil
extends Node

var player : PlayerInstance

func printToHUD(text : String, time: float = 2.0) -> void:
	if player == null: 
		push_error("No player provided!")
		return
		
	player.get_node("HUD/Control/ErrorMessage").text = text
	await get_tree().create_timer(time).timeout
	player.get_node("HUD/Control/ErrorMessage").text = ""
	return
