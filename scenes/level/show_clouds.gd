extends Area2D

func _on_show_clouds_body_entered(body):
	if "Dizzy" in body.name:
		g.is_cutscene_playing = true
		var anim = $danny_on_tree.get_animation("show_clouds")
		anim.track_set_key_value(0, 0, g.dizzy.position)
		anim.track_set_key_value(0, 1, $"../../items/item_short_rope".position)
		anim.track_set_key_value(0, 2, $"../../items/item_short_rope".position)
		anim.track_set_key_value(0, 3, g.dizzy.position)
		$danny_on_tree.current_animation = "show_clouds"
		yield($danny_on_tree, "animation_finished")
		g.is_cutscene_playing = false
		queue_free()
