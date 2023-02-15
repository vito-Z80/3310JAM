extends Node2D

# https://itch.io/jam/nokiajam5

# SHADERS
# https://vk.com/@game_constructors-godot-rabota-s-sheiderom-cherez-kod-osnovy-osnov-2
# 
# 
# 
# 
# 
# 
# 
# 

const START = "Start"
const INFO = "Info"
const EXIT = "Exit"

var label_id = 0
var labels = [START, INFO, EXIT]
var process = false

onready var click = $click
onready var start = $start

func _ready():
	OS.set_window_title("Dizzy 3.5 clone")
	# исключить пункт Exit если HTML5
	if "HTML" in OS.get_name():
		labels.pop_back()
	$Sprite/AnimationPlayer.play("scale")
	yield($Sprite/AnimationPlayer, "animation_finished")
	$Start.text = labels[label_id]
	$Start.visible = true
	$arrow.set_left()
	$arrow2.set_right()
	process = true
	
func _process(delta):
	if process:
		change_label()
		$Start.text = labels[label_id] 
		start_scene()


func start_scene():
	if Input.is_action_just_pressed("ui_select"):
		start.play()
		yield(get_tree(), "idle_frame")
		if labels[label_id] == INFO:
			get_tree().change_scene("res://scenes/info/itfo.tscn")
		if labels[label_id] == START:
			get_tree().change_scene("res://scenes/level/level3.tscn")
		if labels[label_id] == EXIT:
			get_tree().quit()


func change_label():
	if Input.is_action_just_pressed("ui_left"):
		click.play()
		if label_id == 0:
			label_id = labels.size() - 1
		else:
			label_id -= 1

	if Input.is_action_just_pressed("ui_right"):
		click.play()
		if label_id == labels.size() - 1:
			label_id = 0
		else:
			label_id += 1
