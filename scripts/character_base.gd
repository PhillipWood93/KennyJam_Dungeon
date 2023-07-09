extends CharacterBody3D

class_name CharacterBase

const SPEED : float = 1

const ATTACK_RANGE : float = 5.0

@onready var anim_tree : AnimationTree = $AnimationTree
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D
@onready var mesh : Node3D = $Pivot

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if !nav_agent.is_navigation_finished():
		move_to_location(delta)
		anim_tree.set("parameters/locomotion/blend_position", 1)
	else:
		velocity = Vector3.ZERO
		anim_tree.set("parameters/locomotion/blend_position", 0)


func move_to_location(delta):
	var targetPos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	mesh.look_at(targetPos)
	
	velocity = direction * SPEED
	move_and_slide()

func attack(target : CharacterBody3D):
	var dist = target.position - position
	if dist.z > ATTACK_RANGE :
		var loc = Vector3(target.position.x, target.position.y, target.position.z + ATTACK_RANGE)
		move_to_location(loc)
	else:
		anim_tree.set("parameters/AttackTransition/transition_request", true)
		print("Attack")
