extends RigidBody2D

@export var force : float = 200
var direction : Vector2  = Vector2(0,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	apply_impulse(direction.normalized() * force,Vector2(0,0))
	pass # Replace with function body.

func _on_body_entered(body):
	if body is boat:
		body.damage(1.0)
	queue_free()
	pass # Replace with function body.
