extends Node2D

const GRAY_BG = Color("#ff1a1914")
const GRAY_FG = Color("#ff879188")

const HARSH_BG = Color("#ff2b3f09")
const HARSH_FG = Color("#ff9bc700")

const ORIGINAL_BG = Color("#ff43523d")
const ORIGINAL_FG = Color("#ffc7f0d8")

const ITEM_ = "item_"


var cam_limit_pos = Vector2(0,0)
var lifes = 3
var is_game_over = false
var is_end = false

var bg_color = ORIGINAL_BG
var fg_color = ORIGINAL_FG

# пауза основного циклв при диалогах, катсценах и т.д.
var is_dialogue = false
var is_bag_open = false
var is_cutscene_playing = false


var camera:Camera2D
var dizzy:KinematicBody2D
var bag:Node2D
var dialog = preload("res://scenes/dialog/dialog.tscn").instance()
onready var world_width = preload("res://gfx/Dizzy35.png").get_width()
onready var world_height = preload("res://gfx/Dizzy35.png").get_height()

onready var camera_width = ProjectSettings.get_setting("display/window/size/width")
onready var camera_height = ProjectSettings.get_setting("display/window/size/height")

func _ready():
	yield(get_tree(), "idle_frame")
	add_child(dialog)
	VisualServer.set_default_clear_color(bg_color)
	
func _process(delta):
	is_game_over = lifes == 0
	correct_position()
	
	
	
func correct_position():
	if is_instance_valid(dizzy) && is_instance_valid(camera):
		cam_limit_pos.x = clamp(dizzy.position.x - camera_width / 2, camera.limit_left, camera.limit_right - camera_width) 
		cam_limit_pos.y = clamp(dizzy.position.y - camera_height / 2,  camera.limit_top, camera.limit_bottom - camera_height) 


	
func label_name_to_node_name(name:String) -> String:
	return name.to_lower().replace(" ", "_").insert(0, ITEM_)

func node_name_to_label_name(name:String) -> String:
	return name.replace(ITEM_, "").replace("_", " ").capitalize()
	
