extends Node2D


var timer = 0.0

var t = Timer.new()
func _ready():
	t.wait_time = 10
	t.one_shot = true
	add_child(t)
	t.start()
	
func _process(delta):
	to_menu()
	if $Label.visible_characters == len($Label.text):
		return
	
	timer += delta
	if timer >= 0.3:
		$Label.visible_characters += 1
		timer = 0.0

	

func to_menu():
	if Input.is_action_just_pressed("ui_select"):
		yield(get_tree(), "idle_frame")
		get_tree().change_scene("res://scenes/menu.tscn")
	if t.time_left == 0:
		get_tree().change_scene("res://scenes/menu.tscn")
