@tool
extends Resource
class_name PropResource

@export_group("Data")
@export var prop_name: String:
	set(new_setting):
		prop_name = new_setting
		changed.emit()
