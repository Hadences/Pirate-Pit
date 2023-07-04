extends Node

class_name entityManager

@export
var entities = {}

@onready
var spawnPoints : Array[Node] = [
	$Spawnpoints/pos_0,
	$Spawnpoints/pos_1,
	$Spawnpoints/pos_2,
	$Spawnpoints/pos_3,
	$Spawnpoints/pos_4,
	$Spawnpoints/pos_5,
	$Spawnpoints/pos_6,
	$Spawnpoints/pos_7,
]

var taken : Array[int] = []

func spawnMobRandom():
	if(taken.size() == spawnPoints.size()):
		return
	var i : int = 0
	while(taken.has(i)):
		i = randi_range(0,spawnPoints.size()-1)	
	
	taken.append(i)	
	
	spawnMob("pirateBoat", spawnPoints[i].position)

func spawnMob(uuid : String, pos : Vector2 = Vector2(0,0), rot : float = 0.0):
	if(entities.has(uuid)):
		#spawn logic
		var mob = entities.get(uuid).instantiate()
		mob.position = pos
		mob.rotation = rot
		mob.player = get_parent().player
		mob.allow_shoot()
		add_child(mob)
		
