@tool
extends CharacterBody3D
class_name Prop

@onready var interact_label: Label = %InteractLabel
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

@export var prop_resource: PropResource:
	set(new_resource):
		# Disconnect the signal if the previous resource was not null.
		if prop_resource != null and prop_resource.changed.has_connections():
			prop_resource.changed.disconnect(OnResourceChanged)
		prop_resource = new_resource
		OnResourceChanged()
		if prop_resource != null:
			prop_resource.changed.connect(OnResourceChanged)

func OnResourceChanged():
	if !mesh_instance_3d:
		return
	# change visual
	mesh_instance_3d.mesh = prop_resource.prop_mesh
	# change sound
	pass

func _ready():
	OnResourceChanged()
	MakeNonInteractable()
	interact_label.hide()

func MakeInteractable():
	input_ray_pickable = true

func MakeNonInteractable():
	input_ray_pickable = false
	interact_label.hide()


func _on_input_event(_camera, event, _event_position, _normal, _shape_idx):
	if event.is_action_pressed("left_click"):
		print("You clicked ", prop_resource.prop_name)
		Interact()

func Interact():
	pass


func _on_mouse_entered():
	print('mouse entered')
	interact_label.text = prop_resource.interact_instruction
	interact_label.show()


func _on_mouse_exited():
	print('mouse exited')
	interact_label.hide()
