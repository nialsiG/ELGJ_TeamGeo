@tool
extends CharacterBody3D
class_name Prop

@onready var label = $Label

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
	# change visual
	# change sound
	pass

func _ready():
	MakeNonInteractable()

func MakeInteractable():
	label.show()
	input_ray_pickable = true

func MakeNonInteractable():
	label.hide()
	input_ray_pickable = false


func _on_input_event(_camera, event, _event_position, _normal, _shape_idx):
	if event.is_action_pressed("left_click"):
		print("You clicked ", prop_resource.prop_name)


func _on_mouse_entered():
	print('mouse entered')
