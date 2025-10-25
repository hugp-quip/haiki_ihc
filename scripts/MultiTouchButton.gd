@icon("icon/icon.svg")
class_name MultiTouchScreenButton
extends Button

@export var action: String

# @onready var _texture_normal := texture_normal
# @onready var _texture_pressed := texture_pressed

func _gui_input(event):
	var event_pos_adjusted: Vector2 = event.position + global_position
	var inside: bool = event_pos_adjusted.x > position.x and event_pos_adjusted.y > position.y and event_pos_adjusted.x < position.x + size.x and event_pos_adjusted.y < position.y + size.y
	
	if event is InputEventScreenTouch:
		print(str(event.pressed) + ":" + self.name)
		print(str(inside) + ":" + self.name)
		if  event.pressed and !inside:
			print("pressed")
			if toggle_mode:
				toggled.emit()
				button_down.emit()
				button_pressed = true

			else:
				pressed.emit()
				button_down.emit()			
		elif (!event.pressed and !inside):
			print("upp")
			button_up.emit()
			button_pressed = false


