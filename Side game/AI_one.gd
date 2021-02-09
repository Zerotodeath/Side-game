extends KinematicBody2D

enum{
	Idle
	Chaseing
}

onready var may_chase = get_tree().get_nodes_in_group("AI")

var run_speed = 40
var velocity = Vector2.ZERO
var emeny


onready var In_area = $Area2D.get_overlapping_areas()
var can_chase = true

func _ready():
	$Area2D.connect("area_entered", self, "_on_Area2D_area_entered")
	$Area2D.connect("area_exited", self, "_on_Area2D_area_exited")
func _physics_process(delta):
	if emeny != null:
		velocity = position.direction_to(emeny.global_position) * run_speed
	velocity = move_and_slide(velocity)


func _on_Area2D_area_entered(area):
	emeny = area.get_parent()
	can_chase = true


func _on_Area2D_area_exited(area):
	can_chase = false
	emeny = null
