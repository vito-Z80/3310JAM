extends Node2D


var cam_process := false
var is_done := false
var state:GDScriptFunctionState


func _ready():
	g.camera = $camera
	g.camera.current = true
	$AnimatedSprite.play("smoke")
	$AnimationPlayer.play("cam to dizzy")
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(3), "timeout")
	cam_process = true
	$AnimatedSprite.play("idle")
	$AnimationPlayer.play("dizzy down")
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(2), "timeout")
	g.cam_limit_pos.x = clamp($AnimatedSprite.position.x - g.camera_width / 2, g.camera.limit_left, g.camera.limit_right - g.camera_width) 
	g.cam_limit_pos.y = clamp($AnimatedSprite.position.y - g.camera_height / 2,  g.camera.limit_top, g.camera.limit_bottom - g.camera_height) 
	g.dialog.position = g.cam_limit_pos
	g.dialog.new_dialog(g.dialog.well_done)
	yield(g.dialog, "hide")
	yield(get_tree().create_timer(1), "timeout")
	$Timer.start(10)
	is_done = true
	
func _process(delta):
	if cam_process:
		$camera.position.x = $AnimatedSprite.position.x
		$camera.position.y = $AnimatedSprite.position.y
	if is_done:
		if Input.is_action_just_pressed("ui_select") || Input.is_action_just_pressed("ui_accept"):
#			state.resume()
			get_tree().change_scene("res://scenes/menu.tscn")
		if $Timer.time_left <= 0:
			get_tree().change_scene("res://scenes/menu.tscn")
			
