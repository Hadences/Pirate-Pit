extends Area2D

class_name cannon

@export var projectile : PackedScene
var player : boat
var can_shoot : bool = false

var _rotateAllowed = true

var world 

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_tree().root.get_node('world')
	$ShootTimer.wait_time = randf_range(1,2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _rotateAllowed:
		rotateCannon()
	pass

func shoot():
	if !can_shoot:
		return
		
	var SM : soundManager = world.getSoundManager()
	SM.playSound(SM.SOUND.CANNON_SHOOT, 0.8, 0.8)
	
	#get the direction from this to the player
	var dir : Vector2 = player.position - position if player != null && player.is_visible_in_tree() else Vector2.ZERO
	if dir != Vector2.ZERO:	
		dir = dir.normalized()
		var proj = projectile.instantiate()
		proj.global_position += $CannonSprite/ShootPoint.position
		proj.direction = dir
		add_child(proj)

func rotateCannon():
	var dir : Vector2 = player.position - position if player != null && player.is_visible_in_tree() else Vector2.ZERO
	if dir != Vector2.ZERO:	
		#rotate the cannon handle to face player
		$CannonSprite.rotation = atan2(dir.y,dir.x)
	
func _on_shoot_timer_timeout():
	shoot()
	_rotateAllowed = false
	await get_tree().create_timer(0.5).timeout
	_rotateAllowed = true
	pass # Replace with function body.
	
func allow_shoot():
	can_shoot = true
	
