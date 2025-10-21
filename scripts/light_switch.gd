class_name LightSwitch
extends InteractionProvider
@onready var original_energy : float = target[0].light_energy


func _ready() -> void:
	if original_energy > 0:
		doText = "Desligar luz"
		undoText = "Ligar luz"
	else:
		doText = "Ligar luz"
		undoText = "Desligar luz"
	#%InteractableObject.tooltiptext.text = doText
	config_interactable()
	
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

func _switch_tooltiptext():
	if %InteractableObject.tooltiptext.text == doText:
		%InteractableObject.tooltiptext.text = undoText
	else:
		%InteractableObject.tooltiptext.text = doText

func _on_interactable_object_interacted(_source : Node3D) -> void:
	switch()

func do_interaction():
	switch()
