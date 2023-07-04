extends Node
class_name game_manager

var screen_size
var startPos : Vector2 = Vector2.ZERO
var score : int = 0
var mobs = 0

#private values
var _ticks = 0
var _t = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pauseGame()
	get_parent().get_node("HUD").start_screen()
	pass # Replace with function body.
	
func _process(delta):
	if _t >= _ticks:
		if(score % 50 == 0 && mobs <= get_parent().get_node('EntityManager').spawnPoints.size()):
			get_parent().get_node('EntityManager').spawnMobRandom()
			mobs += 1
			score +=1
			_t = 0
	_t += 1 * delta

func start_game():
	var eM : entityManager = get_parent().get_node('EntityManager')
	eM.taken.clear()
	var p : boat = get_parent().player
	p.health = 3
	get_parent().get_node("HUD/HealthBar").update_health(p.health)
	score = 0
	screen_size = get_viewport().get_visible_rect().size
	startPos = Vector2(screen_size.x/2, screen_size.y/2)
	get_parent().player.show()
	getPlayer().position = startPos
	get_parent().get_node("HUD").game_screen()
	get_tree().call_group("mobs","allow_shoot")
	mobs = 0
	restart_game()
	$ScoreTimer.start()
	unpauseGame()
	get_parent().getSoundManager().playSound(get_parent().getSoundManager().SOUND.MUSIC, -10,1)
	pass

func game_over():
	var SM : soundManager = get_parent().getSoundManager()
	
	SM.playSound(SM.SOUND.GAME_OVER, 0.3,1.2)
	
	restart_game()
	pauseGame()
	get_parent().get_node("HUD").game_over_screen()
	await get_tree().create_timer(2.0).timeout
	
	get_parent().get_node("HUD").start_screen()
	
	pass

func restart_game():
	get_tree().call_group("mobs", "queue_free")

func _on_boat_death_event():
	game_over()

func getPlayer():
	return get_parent().player
	
func pauseGame():
	get_tree().paused = true
	
func unpauseGame():
	get_tree().paused = false


func _on_score_timer_timeout():
	score += 1
	updateHUDScore()

func updateHUDScore():
	get_parent().get_node("HUD/ScoreLabel").text = str(score)


func _on_hud_start_button_pressed():
	start_game()
