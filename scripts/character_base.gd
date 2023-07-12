extends CharacterBody3D

class_name CharacterBase
@export_category("Stats")
@export var health : float = 100.0
@export var attackPower : float = 100.0

@export_category("Sound Effects")
@export var deathSound : AudioStreamWAV 

const SPEED : float = 1

const ATTACK_RANGE : float = 5.0

@onready var animTree : AnimationTree = $AnimationTree
@onready var navAgent : NavigationAgent3D = $NavigationAgent3D
@onready var mesh : Node3D = $Pivot
@onready var hitDetection : Area3D = $"Pivot/body/arm-right/hit-detection"
@onready var audioPlayer : AudioStreamPlayer3D = $AudioStreamPlayer3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	animTree.active = true
	hitDetection.monitoring = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if !navAgent.is_navigation_finished():
		animTree.set("parameters/locomotion/blend_position", 1)
	else:
		velocity = Vector3.ZERO
		animTree.set("parameters/locomotion/blend_position", 0)


func move_to_location(target : Node3D):
	var targetPos = navAgent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	mesh.look_at(targetPos)
	
	velocity = direction * SPEED
	move_and_slide()

func attack(target : CharacterBody3D):
	animTree.set("parameters/AttackTransition/transition_request", true)
	await animTree.animation_finished
	animTree.set("parameters/AttackTransition/transition_request", false)

func _on_hitdetection_area_entered(area: Area3D):
		print(area)

func _on_hitdetection_body_entered(body: Node3D):
	print(body)
	body.take_damage(attackPower)

func take_damage(amt):
	health -= amt
	if health <= 0.0:
		die()

func die():
		audioPlayer.stream = deathSound
		animTree.set("parameters/DeathTransition/transition_request", true)
		audioPlayer.play()
		await get_tree().create_timer(10.0).timeout
		queue_free()
