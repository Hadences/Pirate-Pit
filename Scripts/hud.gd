extends CanvasLayer

signal start_button_pressed

func game_over_screen():
	$StartButton.hide()
	$Message.show()
	$ScoreLabel.show()
	$HealthBar.hide()
	
	$Message.text = "GAME OVER"

func game_screen():
	$StartButton.hide()
	$Message.hide()
	$ScoreLabel.show()
	$HealthBar.show()
	
func start_screen():
	$StartButton.show()
	$Message.show()
	$ScoreLabel.hide()
	$HealthBar.hide()
	
	$Message.text = "Pirate Pit"


func _on_start_button_pressed():
	var SM : soundManager = get_parent().getSoundManager()
	SM.playSound(SM.SOUND.CLICK, 1,1)
	start_button_pressed.emit()
