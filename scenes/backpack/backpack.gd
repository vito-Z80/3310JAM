extends Node2D

const MAX_SIZE = 3
const OVER_SCREEN = -10000
const BACK = "Back"
const BACKPACK_FULL = "Backpack full"

onready var label = preload("res://scenes/pref/nokia label.tscn")
var y_id = [12,21,30,39]
var drop_position = Vector2()
var items:Array		# Area2D
var item_id = -1
onready var dizzy = $"../Dizzy"		# получать из вне !!!!!!!!!!!
onready var click = $"../audio/backpack_click"
onready var confirm = $"../audio/backpack_confirm"


var knotted_rope = ["item_short_rope", "item_long_rope"]

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if g.is_dialogue || g.is_cutscene_playing || !dizzy.is_on_floor() || dizzy.is_dead:
			return
		visible = !visible
	if visible:
		select()

func select():
	if Input.is_action_just_pressed("ui_up"):
		click.play()
		if item_id == -1:
			item_id = $labels.get_child_count()
		if item_id == 0:
#			item_id = $labels.get_child_count() - 1
			item_id = -1	# для метки BACK
		else:
			item_id -= 1
		select_color()
	if Input.is_action_just_pressed("ui_down"):
		click.play()
		if item_id == $labels.get_child_count() - 1:
#			item_id = 0
			item_id = -1	# для метки BACK
		else:
			item_id += 1
		select_color()
	if item_id < 0:
		$selector.rect_position.y = y_id[3]
	else:
		$selector.rect_position = $labels.get_child(item_id).rect_position

func select_color():
	# label foreground colors
	for l in $labels.get_children():
		l.add_color_override("font_color", Color(g.fg_color))
	# select label color
	if item_id < 0:
		$bottom.add_color_override("font_color", Color(g.bg_color))
	else:
		$bottom.add_color_override("font_color", Color(g.fg_color))
		$labels.get_child(item_id).add_color_override("font_color", Color(g.bg_color))
		
# при открытии сумки в сумку закидывается предмет пересекающийся с Диззи
# закидывается только один предмет
# если нет места - сообщить об этом.
func open():
	drop_position.x = dizzy.area.position.x
	drop_position.y = dizzy.area.position.y
	item_id = -1 	# установить выделение на метку Back
	if items.size() >= MAX_SIZE:
		pass
	else:
		var intersectengin_area = get_intersect_area(dizzy.area)
		if intersectengin_area != null:
			print("get: " + str(intersectengin_area.name))
			items.append(intersectengin_area)
	create_labels()
	select_color()

# при закрытии сумки выбрасывается выбранный предмет на координаты Диззи
func close():
	yield(get_tree(), "idle_frame")
	for child in $labels.get_children():
		child.free()
	if item_id != -1 && combined():
		g.dialog.new_dialog(g.dialog.ropes_together)
		yield(g.dialog, "hide")
		items.append($"../items/item_knotted_rope")
		return
	if item_id != -1:
		items[item_id].position = dizzy.position
		items.remove(item_id)

func destroy(item:Area2D):
	items.erase(item)
	item.free()

# получить Area2D (item) пересекающийся с Диззи, если таковой имеется.
func get_intersect_area(area:Area2D) -> Area2D:
	for next_area in area.get_overlapping_areas():
		if "item" in next_area.name:
			next_area.position.x = OVER_SCREEN
			next_area.position.y = OVER_SCREEN
			return next_area
	return null
	
# получить метку с именем по id
func get_label(id:int) -> Label:
	var l = label.instance()
	l.rect_position.y = y_id[id]
	l.text = g.node_name_to_label_name(items[id].name)
	l.align = l.ALIGN_CENTER
	return l


func create_labels():
	for id in min(items.size(), MAX_SIZE):
		$labels.add_child(get_label(id))

func combined() -> bool:
	if items[item_id].name in knotted_rope:
		var index = []
		for id in items.size():
			for combo in knotted_rope:
				if combo in items[id].name:
					print(id)
					index.append(id)
		if not index.empty() && index.size() == knotted_rope.size():
			index.invert()
			for id in index:
				print(id)
				items.remove(id)
			return true
	return false


func has_item(item_name:String) -> bool:
	for i in items:
		if item_name in i.name:
			return true
	return false

func _on_backpack_visibility_changed():
	confirm.play()
	g.is_bag_open = visible
	if visible:
		g.correct_position()
		position = g.cam_limit_pos
		open()
	else:
		close()
