extends KinematicBody2D

enum{
	WANDER
	CHASING
	EATING
}

var state = WANDER
var target
export(bool) var can_print = false


onready var Nav = $Navigation2D
var Motion = Vector2.ZERO

func _ready():
	print(target)
	

func _physics_process(delta):
	if target != null:
		var path = Nav.get_simple_path(global_position, target.global_position)
		$Line2D.points = path
		if can_print == true:
			print($Line2D.points)
	move_and_slide(Motion)



func _on_Area2D_body_entered(body):
	var alarm_area = $Area2D.get_overlapping_bodies()
	for body in alarm_area:
		var next_target = body
		target = next_target
