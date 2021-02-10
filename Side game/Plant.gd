extends StaticBody2D

export var can_be_eaten = true
export var health = 50

func _physics_process(delta):
	if health <= 0:
		queue_free()
