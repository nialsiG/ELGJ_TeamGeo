extends Control
class_name TimeManager

@export var time_in_seconds: int = 10

# nodes
@onready var time_label: Label = %TimeLabel
@onready var timer: Timer = $Timer

# runtime variables
var current_time: Dictionary[String, int]


func _ready():
	SignalManager.StartGame.connect(Reset)
	SignalManager.StopGame.connect(Stop)
	SignalManager.PauseGame.connect(Pause)
	SignalManager.UnpauseGame.connect(Unpause)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		print("pause / unpause")
		if timer.paused:
			SignalManager.UnpauseGame.emit()
		else:
			SignalManager.PauseGame.emit()

func _on_timer_timeout():
	current_time["seconds"] -= 1
	if current_time["seconds"] <= 0 and current_time["minutes"] == 0:
		SignalManager.StopGame.emit()
		return
	elif current_time["seconds"] < 0 and current_time["minutes"] > 0:
			current_time["minutes"] -= 1
			current_time["seconds"] = 59
	UpdateTimeLabel()


func UpdateTimeLabel():
	var time_text: String = str(current_time["minutes"], ":")
	if current_time["seconds"] < 10:
		time_text += "0"
	time_text += str(current_time["seconds"])
	time_label.text = time_text


func Reset():
	var minutes = floor(time_in_seconds / 60)
	var seconds = time_in_seconds % 60
	current_time = {"minutes": minutes, "seconds": seconds}
	print(current_time)
	UpdateTimeLabel()
	Unpause()
	timer.start()

func Stop():
	current_time = {"minutes": 0, "seconds": 0}
	UpdateTimeLabel()
	timer.stop()

func Pause():
	timer.paused = true

func Unpause():
	timer.paused = false
