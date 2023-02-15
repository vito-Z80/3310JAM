extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= delta * 8
	if position.y < -283 || Input.is_action_just_pressed("ui_select"):
		yield(get_tree(), "idle_frame")
		get_tree().change_scene("res://scenes/menu.tscn")
