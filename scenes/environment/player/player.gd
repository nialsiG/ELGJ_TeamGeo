extends CharacterBody3D

@export var move_speed: float = 10.0

# nodes
@onready var pivot: Node3D = $Pivot

# runtime variables
var target_velocity: Vector3 = Vector3.ZERO
var can_move: bool = false


func _ready():
	SignalManager.StartGame.connect(OnStart)
	SignalManager.StopGame.connect(OnStop)
	SignalManager.PauseGame.connect(OnPause)
	SignalManager.UnpauseGame.connect(OnUnpause)

func OnStart():
	global_position = Vector3(0, 0, 0)
	can_move = true

func OnStop():
	can_move = false

func OnPause():
	can_move = false

func OnUnpause():
	can_move = true


func _physics_process(delta):
	if !can_move:
		return
	var direction: Vector3 = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
			direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1

	if direction != Vector3.ZERO:
			direction = direction.normalized()
			# Setting the basis property will affect the rotation of the node.
			pivot.basis = Basis.looking_at(-direction)

	# Ground Velocity
	target_velocity.x = direction.x * move_speed
	target_velocity.z = direction.z * move_speed
	
	# Moving the Character
	velocity = target_velocity
	move_and_slide()
