extends Node2D

func _process(delta):
	if get_tree().get_nodes_in_group() < 5:
		print(get_tree().get_nodes_in_group())
