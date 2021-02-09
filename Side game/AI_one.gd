extends KinematicBody2D

enum{
	Idle
	Chaseing
}

onready var may_chase = get_tree().get_nodes_in_group("AI")

var run_speed = 40
var velocity = Vector2.ZERO
var target

var fighting = false
var eating

var hungry = 49
var searching = true


onready var In_area = $Area2D.get_overlapping_areas()
var can_chase = true

func _ready():
	$Area2D.connect("area_entered", self, "_on_Area2D_area_entered")
	$Area2D.connect("area_exited", self, "_on_Area2D_area_exited")
func _physics_process(delta):
	print(eating)
	if target != null:
		velocity = position.direction_to(target.global_position) * run_speed
	velocity = move_and_slide(velocity)


func _on_Area2D_area_entered(area):
	target = area.get_parent()
	can_chase = true
	if target.is_in_group("AI"):
		fighting = true
	elif target.is_in_group("Plant"):
		eating = true


func _on_Area2D_area_exited(area):
	can_chase = false
	target = null
	fighting = false
