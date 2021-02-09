extends KinematicBody2D

enum{
	Idle
	Chaseing
}

onready var hithurtbox = $hithurtbox.get_overlapping_areas()

export var can_attack = true

var run_speed = 40
var velocity = Vector2.ZERO
var target

var fighting = false
var eating

export var health = 100
export var damage = 25
var searching = true
var previos_target = [target, "old"]
onready var In_area = $Area2D.get_overlapping_areas()
var can_chase = true

func _ready():
	$Area2D.connect("area_entered", self, "_on_Area2D_area_entered")
	$Area2D.connect("area_exited", self, "_on_Area2D_area_exited")
	$hithurtbox.connect("area_entered", self, "_on_hithurtbox_area_entered")
	$hithurtbox.connect("area_exited", self, "_on_hithurtbox_area_exited")
	$Timer.connect("timeout", self, "hit_timer")
func _physics_process(delta):
	if health <= 0:
		queue_free()
	if target != null:
		velocity = position.direction_to(target.global_position) * run_speed
	velocity = move_and_slide(velocity)
	

func _on_Area2D_area_entered(area):
	target = area.get_parent()
	can_chase = true
	if target.is_in_group("AI"):
		fighting = true
	previos_target.insert("nothing", target)
	print(previos_target)
	


func _on_Area2D_area_exited(area):
	can_chase = false
	target = null
	fighting = false


func _on_hithurtbox_area_entered(area):
	target = area.get_parent()
	if target.is_in_group("Plant"):
		eating = true
	$Timer.start()

func _on_hithurtbox_area_exited(area):
	eating = false
	$Timer.stop()

func hit_timer():
	if fighting == true:
		target.health -= damage

