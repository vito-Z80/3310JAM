extends Node2D

var is_rope_set = false
var starting_count = 3
var x = 0
var y = 0
var time = 0
func _process(delta):
	if starting_count == 0 && is_rope_set:
		time += delta
		if time > 0.03:
			time = 0.0
			if rand_range(0,100) > 70:
				x = rand_range(-1,1)
			else:
				y = rand_range(-1,1)
		$Sprite.offset.x = x
		$Sprite.offset.y = y
		$"../portal".visible = true
		
func _on_machine_area_entered(area):

	if is_rope_set:
		if "starting_handle" in area.name:
			starting_count -= 1
			if starting_count > 0:
				g.dialog.new_dialog(g.dialog.starting_handle_work_not_start)
				yield(g.dialog, "hide")
#				g.bag.add(area)
			else:
				g.dialog.new_dialog(g.dialog.starting_handle_go)
				g.bag.destroy(area)
#				area.free()
				yield(g.dialog, "hide")
	else:
		if "starting_handle" in area.name:
			g.dialog.new_dialog(g.dialog.starting_handle_cant_go_machine)
			yield(g.dialog, "hide")
		if "knotted_rope" in area.name && !is_rope_set:
			is_rope_set = true
			g.bag.destroy(area)
#			area.free()
			g.dialog.new_dialog(g.dialog.rope_complex)
			yield(g.dialog, "hide")
