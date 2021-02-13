extends KinematicBody2D

var Motion = Vector2.ZERO
export(float) var speed = 50
onready var target = get_parent().get_node("StaticBody2D")
var dir
var go_to_target = true

func _physics_process(delta):
	dir = Motion

	$"Main cast".cast_to = dir * 2.5
	
	if go_to_target == true:
		Motion = position.direction_to(target.position) * speed
	
	
	Motion = move_and_slide(Motion)

