@tool
class_name TextInteractionProvider
extends InteractionProvider

@export var interactionText : String 

func _ready():
	
	if interactionText == "": interactionText = "no text provided"
	if doText == "": doText = "no text provided"
	$InteractionText.text = interactionText
	config_interactable()

func _on_interactable_object_interacted(interactionSource : Node3D) -> void:
	if interactionSource is PlayerInstance:
		$InteractableObject.tooltiptext.hide()
		$InteractableObject.disable_tooltip()
		$InteractionText.show()

func _on_interactable_object_player_exited(_player:Node3D) -> void:
	$InteractableObject.enable_tooltip()
	$InteractionText.hide()
		
		
