extends RigidBody2D
class_name boat

signal deathEvent

var movementInput : Vector2 = Vector2(0,0)

#player data values
@export var maxSpeed : float = 0.0
@export var acceleration : float = 0.0
@export var linearDrag : float = 0.0
@export var health : float = 3
var changingDir = true if ((linear_velocity.x > 0.0 && movementInput.x < 0.0) || (linear_velocity.x < 0.0 && movementInput.x > 0.0)
|| (linear_velocity.y > 0.0 && movementInput.y < 0.0) || (linear_velocity.y < 0.0 && movementInput.y > 0.0)) else false

#other
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # hide the player initially
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_movementInputs()
	applyLinearDrag()

func _physics_process(delta):
	screen_size = get_viewport_rect().size
	moveUpdate()


func applyLinearDrag():
	if(movementInput.length() < 0.4 || changingDir):
		linear_damp = linearDrag
	else:
		linear_damp = linearDrag/2
	
func damage(value : float):
	health -= value
	if(health <= 0):
		health = 0
		hide()
		deathEvent.emit()
	get_parent().get_node("HUD/HealthBar").update_health(health)
	get_parent().getSoundManager().playSound(get_parent().getSoundManager().SOUND.HURT, 1,1)
		

func moveUpdate():
	#update direction of sprite
	if(movementInput.x < 0):
		$AnimatedSprite2D.flip_h = true
	elif movementInput.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	#using the input values of the player, move the player torwards that direction	
	apply_force(movementInput * acceleration)
	if(abs(linear_velocity.length()) > maxSpeed):
		linear_velocity = linear_velocity.normalized() * maxSpeed
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	

func update_movementInputs():
	movementInput = Vector2.ZERO
	if(Input.is_action_pressed("move_down")):
		movementInput.y += 1
	if(Input.is_action_pressed("move_up")):
		movementInput.y += -1
	if(Input.is_action_pressed("move_left")):
		movementInput.x += -1
	if(Input.is_action_pressed("move_right")):
		movementInput.x += 1
	movementInput = movementInput.normalized()
	
	
	

