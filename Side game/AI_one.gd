extends KinematicBody2D



func _ready():
	print(get_parent().get_node("AI 2").position)
	print(position)
