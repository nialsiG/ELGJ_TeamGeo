@tool
extends Resource
class_name PropResource

@export_group("Data")
@export var prop_name: String:
	set(new_setting):
		prop_name = new_setting
		changed.emit()

@export var prop_mesh: Mesh:
	set(new_setting):
		prop_mesh = new_setting
		changed.emit()

@export var interact_instruction: String:
	set(new_setting):
		interact_instruction = new_setting
		changed.emit()
