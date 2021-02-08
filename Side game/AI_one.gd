extends KinematicBody2D

onready var A2 = get_parent().get_node("AI 2")
onready var may_chase = get_tree().get_nodes_in_group("AI")

var run_speed = 40
var velocity = Vector2.ZERO

onready var In_area = $Area2D.get_overlapping_areas()
var can_chase = true

func _ready():
	pass


func _physics_process(delta):
	print(can_chase)
	for area in In_area:
		if area == "Area2D":
			if is_in_group("AI"):
				can_chase = true
		else:
			can_chase = false
		
	
	if can_chase == true:
		velocity = position.direction_to(A2.position) * run_speed
	velocity = move_and_slide(velocity)

