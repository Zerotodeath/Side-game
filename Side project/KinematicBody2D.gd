extends KinematicBody2D

onready var Main_ray = $"Main cast"

onready var Up_ray = $"Raycast/Top cast/Up ray"
onready var Up_left = $"Raycast/Top cast/Up left"
onready var Up_right = $"Raycast/Top cast/Up right"

onready var Right_ray = $"Raycast/Middle/Right ray"
onready var Left_ray = $"Raycast/Middle/Left ray"

onready var Down_ray = $"Raycast/Bottom ray/Down ray"
onready var Down_right = $"Raycast/Bottom ray/Down right ray"
onready var Down_left = $"Raycast/Bottom ray/Down left"

var Motion = Vector2.ZERO
export(float) var speed = 50
onready var target = get_parent().get_node("StaticBody2D")
var dir
var go_to_target = true

func _physics_process(delta):
	if Main_ray.is_colliding():
		rays()
	
	
	dir = Motion
	
	$"Main cast".cast_to = dir * 2
	
	if go_to_target == true:
		Motion = position.direction_to(target.position) * speed
	
	
	Motion = move_and_slide(Motion)

func rays():
	var go_to_loop = false
	if go_to_loop == false:
		go_to_target = false
		go_to_loop = true
	if go_to_loop == true:
		Motion.x += 150
