extends Node2D

class_name soundManager

enum SOUND{
	CANNON_SHOOT,
	HURT,
	GAME_OVER,
	CLICK,
	MUSIC
}

@onready var soundEffects = {
	SOUND.CANNON_SHOOT: $CANNON_SHOOT,
	SOUND.HURT: $HURT,
	SOUND.GAME_OVER : $GAME_OVER,
	SOUND.CLICK : $CLICK,
	SOUND.MUSIC : $MUSIC
}

func playSound(sound : SOUND, volume : float = 1, pitch : float = 1):
	if soundEffects.has(sound):
		var s : AudioStreamPlayer = soundEffects[sound]
		s.volume_db = volume
		s.pitch_scale = pitch
		s.play()
		
