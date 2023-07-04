extends Node2D

@onready var hearts = [$heart_0, $heart_1, $heart_2]

func update_health(value : float):
	var val = int(value)
	for i in len(hearts):
		if(i < val):
			hearts[i].show()
		else:
			hearts[i].hide()
