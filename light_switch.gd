class_name LightSwitch
extends Switch
@onready var original_energy : float = target[0].light_energy

func _ready() -> void:
	if original_energy > 0:
		switch_text1 = "Ligar luz"
		switch_text2 = "Desligar luz"

	else:
		switch_text1 = "Desligar luz"
		switch_text2 = "Ligar luz"
		
func switch():
	if target[0].light_energy == original_energy:
		for targ in target:
			targ.light_energy = 0
		%AnimationPlayer.play("flip")
	else:
		for targ in target:
			targ.light_energy = original_energy
		%AnimationPlayer.play_backwards("flip")
	
	_switch_tooltiptext()







func _on_player_proximity_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		%tooltiptext.show()


func _on_player_proximity_area_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		%tooltiptext.hide()
