extends CharacterBody3D

class_name CharacterBase

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var anim_tree : AnimationTree = $AnimationTree
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	anim_tree.set("parameters/locomotion/blend_position", velocity.z)
	
	if !nav_agent.is_navigation_finished():
		move_to_location(delta) 


func move_to_location(delta):
	var targetPos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	
	velocity = direction * SPEED
	move_and_slide()

func jump():
		velocity.y = JUMP_VELOCITY
