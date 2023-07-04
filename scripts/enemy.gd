extends CharacterBase

#@onready var target : Node3D = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	super(delta)
	
#	nav_agent.target_position = target.position
#	move_to_location(delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
