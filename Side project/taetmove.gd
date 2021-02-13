extends KinematicBody2D

var motion = Vector2.ZERO

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_down"):
		motion.x = -150
	
	motion = move_and_slide(motion)
