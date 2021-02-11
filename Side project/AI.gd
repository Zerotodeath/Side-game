extends KinematicBody2D

enum{
	WANDER
	CHASING
	EATING
}

var state = WANDER

onready var Nav = $Navigation2D
var Motion = Vector2.ZERO

func _physics_process(delta):
	
	move_and_slide(Motion)
