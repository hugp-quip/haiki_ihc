class_name PlayerInstance
extends CharacterBody3D

const SPEED := 5.0
const JUMP_VELOCITY := 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var fixed_camera : Camera3D
var look_dir : Vector2
const FP_SENS := 40
var capMouse = false

# @onready var third_p_camera = get_node("Camera_Controller/Camera_Target/Camera3D")
# @onready var first_p_camera = get_node("fpcamera")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Util.player = self
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_released("pause"):
			if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion: look_dir = event.relative*0.01
	elif event is InputEventMouseButton:
		if !event.pressed:
			if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

			
			var ray : RayCast3D = %CamRaycast
			ray.collide_with_bodies = false
			#print(ray.is_colliding())
			if ray.is_colliding():
				var maybe_interactable_child = ray.get_collider()
				#print(maybe_interactable_child)
				if maybe_interactable_child != null:
					var maybe_interactable = maybe_interactable_child.get_parent()
					if maybe_interactable is Interactable:
						maybe_interactable.interact(self)




func rotate_camera(delta : float, sens_mod: float = 1.0):
	var camera = $fpcamera
	rotation.y -= look_dir.x * FP_SENS * delta
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * FP_SENS * sens_mod*delta, -1.5, 1.5)
	look_dir = Vector2.ZERO

func handle_inputs(delta : float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# if Input.is_action_just_pressed("switch_camera"):
	# 	$MeshInstance3D/MeshInstance3D.show()
	# 	if fixed_camera != get_viewport().get_camera_3d():
	# 		fixed_camera.make_current()
	# 	else:
	# 		$Camera_Controller/Camera_Target/Camera3D.make_current()

	if Input.is_action_just_pressed("first_person"):
		$MeshInstance3D/MeshInstance3D.hide()
		$fpcamera.make_current()
	
	#if Input.is_action_just_pressed("pause"):

		



func _physics_process(delta):
	
	handle_inputs(delta)

	

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var direction : Vector3 

	#var camera_at := get_viewport().get_camera_3d()

	# match camera_at: 
	# 	#third_p_camera: direction = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
		
	# 	#fixed_camera: direction = (fixed_camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
		
	# 	first_p_camera: 
			
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
			
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		#look_at(velocity, Vector3.UP)	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		

	move_and_slide()
	
	# if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and get_viewport().get_camera_3d() == $fpcamera:
	rotate_camera(delta)

	# elif input_dir != Vector2(0,0):
	# 	var move_rot := Vector2(direction.z, direction.x)*-1
	# 	rotation.y = move_rot.angle() 

	# # Check for collisions after moving and sliding
	# for i in get_slide_collision_count():
	# 	var collision = get_slide_collision(i)
	# 	if collision.get_collider() is RigidBody3D : # Or RigidBody2D
	# 		var rigid_body = collision.get_collider()
	# 		# Apply an impulse to the RigidBody in the opposite direction of the collision normal
	# 		rigid_body.apply_central_impulse(-collision.get_normal() * 0.5)

	
	
