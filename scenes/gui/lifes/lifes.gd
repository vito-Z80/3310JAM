extends Node2D

onready var sprites = $Node2D
onready var hp = $ColorRect
var txt = preload("res://gfx/items/egg.png")
var offset = Vector2(64,4)
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(0, g.lifes):
		var sprite = Sprite.new()
		sprite.texture = txt
		sprite.position.x += x * 8
		sprites.add_child(sprite)

func sub_life():
	if sprites.get_child_count() > 0:
		sprites.get_child(0).queue_free()
#	visible = true
#	yield(get_tree(), "idle_frame")

func _process(delta):
	bar()
	g.correct_position()
	position = g.cam_limit_pos + offset
	if sprites.get_child_count() > g.lifes:
		sub_life()

func hp_down():
	hp.rect_size.x -= 0.1
	if fmod(hp.rect_size.x, 1) < 0.1:
		return true
	else:
		return false
		
func bar():
	if !g.is_cutscene_playing:
		visible = true
	else:
		visible = false

