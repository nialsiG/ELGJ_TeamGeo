extends Control
class_name PauseMenu

func _ready():
	SignalManager.PauseGame.connect(Pause)
	SignalManager.UnpauseGame.connect(Unpause)
	# hide by default
	hide()

func Pause():
	show()

func Unpause():
	hide()

func _on_close_button_pressed():
	Unpause()
