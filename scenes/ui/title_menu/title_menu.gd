extends Control
class_name TitleMenu

func _ready():
	SignalManager.StartGame.connect(OnStart)
	SignalManager.StopGame.connect(OnStop)

func _on_start_button_pressed():
	SignalManager.StartGame.emit()

func OnStart():
	hide()

func OnStop():
	show()
