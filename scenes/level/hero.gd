extends KinematicBody2D

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

onready var cloud_1 = $"../cloud_1"
onready var cloud_2 = $"../cloud_2"

onready var area = $Dizzy
onready var animation = $AnimatedSprite

onready var a_drown = $"../audio/drown"
onready var a_hp_lost = $"../audio/hp_lost"

const WALK_FORCE = 400
const WALK_MAX_SPEED = 50
const STOP_FORCE = 300000
const JUMP_SPEED = 36.0

const FIRE_NAME = "fire"

var rough = 2.0
var velocity = Vector2()
var pre_position = Vector2()
var last_floor_position = Vector2()
var pre_direction:int = 0
var is_jump:int
var direction:int
var is_drowned = false
var is_dead = false

	

func _process(delta):
	if g.is_end:
		return
	
	if g.is_bag_open || g.is_dialogue || g.is_cutscene_playing || is_drowned || is_dead:
		if is_dead:
			if animation.frame == 4:
				animation.stop()
			velocity.y += gravity * delta 
			velocity.x = 0
			velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
		return
	hp_down()
	if dead():
		return
	
	# Horizontal movement code. First, get the player's input.
	pre_position = position
	if is_on_floor() || gravity < 1:
		direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	var walk = WALK_FORCE * direction
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE :
		# The velocity, slowed down a bit, and then reassigned.
#		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
		velocity.x = 0.0
		if is_on_floor():
			animation.animation = "idle"
			if position.y < 101:	# что бы не респался на берегу (оттуда нет выхода)
				last_floor_position = position
		else:
			if position.x == pre_position.x:
				animation.animation = "jump_idle"
	else:
		velocity.x += walk * delta
		if is_on_floor():
			animation.animation = "walk"
		else:
			animation.animation = "jump"
		animation.flip_h = velocity.x < 0
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta 


	# Move based on the velocity and snap to the ground.
	# true параметр отвечает за то что бы не скатывался с наклонных поверхностей
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP, true)

	var asdf = 0
	if is_on_floor() || gravity < 1:
		if Input.is_action_just_pressed("ui_up"):
			if position.y < 101 && gravity > 1:	# что бы не респался на берегу (оттуда нет выхода)
				last_floor_position = position
			asdf = velocity.y
			velocity.y = -JUMP_SPEED * rough
			rough = 2.0
	if g.bag.has_item("skyboots"):
		if cloud_1.overlaps_body(self) || cloud_2.overlaps_body(self):
			if velocity.y >= asdf:
				gravity = 0.3
				velocity.y = 20
		else:
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_item():
	var items = area.get_overlapping_areas()
	if !items.empty():
		# All items must contains "item_" on name.
		if "item" in items[0].name:
			return items[0]
	return null


func dead() -> bool:
	is_drowned = position.y >= 104
	is_dead = $"../lifes".hp.rect_size.x == 0
	if is_drowned:
		animation.animation = "drown"
		a_drown.play()
		yield(get_tree().create_timer(3), "timeout")
		reset()
	if is_dead:
		animation.animation = "dead"
		yield(get_tree().create_timer(3), "timeout")
		reset()
	return is_drowned || is_dead

func reset():
	velocity.x = 0
	direction = 0
	is_drowned = false
	is_dead = false
	animation.play("idle")
	position = last_floor_position
	$"../lifes".hp.rect_size.x = 16
	g.lifes -= 1
	yield(get_tree(), "idle_frame")

func hp_down():
	for a in area.get_overlapping_areas():
		if FIRE_NAME in a.name:
			if $"../lifes".hp_down():
				a_hp_lost.play()
				return


func to_portal():
	g.is_end = true
	yield(get_tree().create_timer(1), "timeout")
	animation.play("smoke")
	yield(animation,"animation_finished")
	animation.frame = 7
	animation.stop()
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://scenes/final scene/final scene.tscn")
