extends AnimatedSprite

# Данни жалуется что его на дерево забросило.
func _on_danny_on_tree_body_entered(body):
	if "Dizzy" in body.name:
		body.animation.animation = "idle"
		g.is_cutscene_playing = true
		var anim = $show_danny.get_animation("show_danny_on_tree")
		var dizzy_pos = Vector2(g.dizzy.position.x, g.dizzy.position.y)
		var danny_pos = Vector2(position.x, position.y)
		anim.track_set_key_value(0, 0, dizzy_pos)
		anim.track_set_key_value(0, 1, danny_pos)
		anim.track_set_key_value(0, 2, danny_pos)
		var down = Vector2(position.x, position.y + 90)
		anim.track_set_key_value(0, 3, down)
		anim.track_set_key_value(0, 4, down)
		anim.track_set_key_value(0, 5, danny_pos)
		anim.track_set_key_value(0, 6, danny_pos)
		$show_danny.current_animation = "show_danny_on_tree"
		yield($show_danny, "animation_finished")
#		print("danny showing")
		g.dizzy.position = danny_pos
		g.correct_position()
		g.dialog.new_dialog(g.dialog.danny_on_tree)
		yield(g.dialog, "hide")
		g.dizzy.position = dizzy_pos
		g.correct_position()
		$danny_on_tree.queue_free()
		anim = $show_danny.get_animation("to_dizzy")
		anim.track_set_key_value(0, 0, danny_pos)
		anim.track_set_key_value(0, 1, dizzy_pos)
		$show_danny.current_animation = "to_dizzy"
		yield($show_danny, "animation_finished")
		g.is_cutscene_playing = false

# Диззи спасает Данни. Данни дает Диззи ботнки.
# Нельзя дать взять Диззи веревку пока не будет выполненно _on_danny_on_tree_body_entered(body
func _on_danny_saved_area_entered(area):
#	print(area.name)
	if area.name == "item_long_rope":
		g.dialog.new_dialog(g.dialog.danny_saved)
		yield(g.dialog, "hide")
		position.y += 84
		animation = "danny_saved"
		$danny_saved.queue_free()
		$"../items/item_skyboots".position.x = position.x + 20
		$"../items/item_skyboots".position.y = position.y + 1
		$"../items/item_skyboots".visible = true
		# вернуть веревку в сумку
#		g.bag.open()
