extends CharacterBase


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	super(delta)
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		var camera : Camera3D = get_tree().get_first_node_in_group("Camera")
		var mousePos = get_viewport().get_mouse_position()
		var rayLength = 100
		var from = camera.project_ray_origin(mousePos)
		var to = from + camera.project_ray_normal(mousePos) * rayLength
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = from
		rayQuery.to = to
		var space = get_world_3d().direct_space_state
		var result = space.intersect_ray(rayQuery)
		print(result)
		nav_agent.target_position = result.position

func click_to_move():
	pass
