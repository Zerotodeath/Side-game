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
var eating = false
var loop = false

export var health = 100
export var damage = 25
var searching = true
var previos_target
var life_cycle = false
export var eat_damage = 1
onready var next_target
var can_chase = true

func _ready():
	
	$Area2D.connect("area_entered", self, "_on_Area2D_area_entered")
	$Area2D.connect("area_exited", self, "_on_Area2D_area_exited")
	$hithurtbox.connect("area_entered", self, "_on_hithurtbox_area_entered")
	$hithurtbox.connect("area_exited", self, "_on_hithurtbox_area_exited")
	$Timer.connect("timeout", self, "hit_timer")
func _physics_process(delta):
	
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
	if loop == true:
		last_targat()
	if target == null:
		life_cycle = false
	if health <= 0:
		queue_free()
	if target != null:
		velocity = position.direction_to(target.global_position) * run_speed
	velocity = move_and_slide(velocity)
	

func _on_Area2D_area_entered(area):
	if loop == false:
		target = area.get_parent()
		can_chase = true
		loop = true
	if target == null:
		loop = false


func _on_Area2D_area_exited(area):
	can_chase = false
	target = null

func _on_hithurtbox_area_entered(area):
	if target != null:
		if target.is_in_group("Plant"):
			eating = true
		elif target.is_in_group("AI"):
			if target.target == null:
				target = null
			fighting = true
		else:
			fighting = false
			eating = false
	target = area.get_parent()
	$Timer.start()

func _on_hithurtbox_area_exited(area):
	if next_target != null && target != null && previos_target != null:
		if target.is_in_group("Plant"):
			print(next_target.name, " ", target.name, " ", previos_target.name, " ", name)
	target = null

func hit_timer():
	if fighting == true:
		if target != null:
			target.health -= damage
	elif eating == true:
		if target != null:
			target.health -= eat_damage
	
	if target != null:
		if target.is_in_group("AI"):
			if target.target == null:
				target = null


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
				nexttarget()
			else:
				queue_free()
		

func nexttarget():
	var next_target_area = $Area2D.get_overlapping_areas()
	for area in next_target_area:
		next_target = area.get_parent()
		target = next_target
		if target == next_target:
			loop = false
		if next_target != null:
			if next_target.is_in_group("AI"):
				fighting = true
			elif next_target.is_in_group("Plant"):
				eating = true
		

