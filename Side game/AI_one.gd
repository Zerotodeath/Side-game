extends KinematicBody2D

enum{
	Idle
	Chaseing
}

onready var hithurtbox = $hithurtbox.get_overlapping_areas()

export var can_attack = true
export var can_print = false

var run_speed = 40
var velocity = Vector2.ZERO
var target

var fighting = false
var eating

export var health = 100
export var damage = 25
var searching = true
var previos_target
var life_cycle = false
onready var next_target
var can_chase = true

func _ready():
	$Area2D.connect("area_entered", self, "_on_Area2D_area_entered")
	$Area2D.connect("area_exited", self, "_on_Area2D_area_exited")
	$hithurtbox.connect("area_entered", self, "_on_hithurtbox_area_entered")
	$hithurtbox.connect("area_exited", self, "_on_hithurtbox_area_exited")
	$Timer.connect("timeout", self, "hit_timer")
func _physics_process(delta):
	last_targat()
	if target == null:
		life_cycle = false
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
	if target.is_in_group("Plant"):
		eating = true


func _on_Area2D_area_exited(area):
	can_chase = false
	target = null
	fighting = false


func _on_hithurtbox_area_entered(area):
	target = area.get_parent()
	target.health -= damage
	$Timer.start()

func _on_hithurtbox_area_exited(area):
	area.get_parent().health -= 25
	$Timer.stop()

func hit_timer():
	if fighting == true:
		target.health -= damage
	print(target.name, " ", target.health, target)


func last_targat():
	if target != null:
		if life_cycle == false:
			previos_target = target
		life_cycle = true
	elif target == null:
		if life_cycle == true:
			if previos_target != null:
				target = previos_target
			elif previos_target == null:
				next_target()
			else:
				queue_free()

func next_target():
	var next_target_area = $Area2D.get_overlapping_areas()
	for area in next_target_area:
		target = area.get_parent()
