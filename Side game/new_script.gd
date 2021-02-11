extends "res://AI_one.gd"


func _physics_process(delta):
	breed()
	son = self.duplicate()
	if has_stats == true:
		if target == null:
			son.max_health = stats[0]
			son.eat_damage = stats[1]
			son.run_speed = stats[2]
			son.damage = stats[3]
			son
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
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
	#if next_target != null && target != null && previos_target != null:
		#if target.is_in_group("Plant"):
	#		print(next_target.name, " ", target.name, " ", previos_target.name, " ", name)
	target = null
	last_targat()

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
	
	if target != null:
		if target.is_in_group("AI"):
			stats.insert(0, target.max_health + health / 1.75)
			stats.insert(1, target.eat_damage + damage / 6)
			stats.insert(2, target.run_speed * 1.35 + run_speed/2.25 )
			stats.insert(3, target.damage)
			has_stats = true
		else:
			has_stats = false


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
		

func breed():
	son = self.duplicate()
	if has_stats == true:
		max_health = stats[0]
		eat_damage = stats[1]
		run_speed = stats[2]
		damage = stats[3]
		son.position = 0
	
