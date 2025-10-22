extends Label

func _physics_process(delta: float) -> void:
	text = "fps: "+str(Engine.get_frames_per_second())

func _on_down_button_down() -> void:
	pass # Replace with function body.
