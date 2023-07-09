extends CharacterBase

var hitResult : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	super(delta)
	
	if Input.is_action_pressed("interact"):
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
		hitResult = result
		nav_agent.target_position = result.position
		print(result.collider) 
		#if enemy and we are in range then attack
		
		#else move to enemy and attack
		
