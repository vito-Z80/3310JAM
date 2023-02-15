extends Node2D

onready var camera = $".."
onready var text_label = $"ColorRect/text"
onready var speaker_name_label = $"ColorRect/spaker_name"

const TEXT_Y = 20
const TEXT_BOTTOM_Y = 48
const PRINT_SPEED = 12.0

var is_text_printed:bool = false
var is_dialog_completed = false

var dialogues:Array
var time = 0


var danny_on_tree = [
	{"Danny":"HELP!!!\nIt`s me, Danny!"},
	{"Dizzy":"What are you doing in here???"},
	{"Danny":"I put on these\nfunny boots!"},
	{"Danny":"They made\nme\nfloat up!"},
	{"Dizzy":"Danny, where is everybody?"},
	{"Danny":"The evil wizard ZAKS is back!"},
	{"Danny":"He`s kidnapped them all and taken them"},
	{"Danny":"to his magic kingdom!"},
	{"Dizzy":"\nGOSH!"},
	{"Dizzy":"I must find some way to get there"},
	{"Dizzy":"and rescue them all!"},
	{"Danny":"Dizzy... why not start by finding a way"},
	{"Danny":"to pull me down?"},
	{"Danny":"\nHELP !!!!"},
]

var danny_saved = [
	{"":"You throw the rope and pull Danny down!"},
	{"Danny":"Thanks, Dizzy! Here you take the boots!"},
	{"Dizzy":"Are they safe?"},
	{"Danny":"Of course!"},
	{"Danny":"You`re much heavier than I am!"}
]

var ropes_together = [
	{"":"You deftly tie the two ropes together!"}
]

var rope_complex = [
	{"":"You wind the rope round the"},
	{"":"complex cogwheels!"}
]


var starting_handle_cant_go_machine = [
	{"":"The wheels aren`t connected,"},
	{"":"so the machine can`t go!"}
]

var starting_handle_work_not_start = [
	{"":"The machine coughs but doesn't start!"}
]

var starting_handle_go = [
	{"":"The machine finally catches and starts to go!"}
]

var well_done = [
	{"":"Well done, you made it to MAGICLAND!"},
	{"":"Now all you need to do"},
	{"":"is to rescue everybody...."},
	{"":"...and find a way to get back home!"},
	{"":"The adventure continues on"},
	{"":"ZX-SPECTRUM computer in 1990"},
	{"":"\nBye Bye!"}
]


func _ready():
	$arrow.set_blink()

func _process(delta):
	g.is_dialogue = visible
	if text_label == null:
		return
	
	if is_dialog_completed:
		visible = false
		return
		
#	tmp_vec.x = clamp(g.camera.position.x + g.camera.offset.x, g.camera.limit_left,g.camera.limit_right - g.camera_width)
#	tmp_vec.y = clamp(g.camera.position.y + g.camera.offset.y, g.camera.limit_top,g.camera.limit_bottom - g.camera_height)
#	tmp_vec.x = g.camera.position.x
#	tmp_vec. = g.camera.position.y
	
#	$ColorRect.rect_position = to_local(tmp_vec)
	
	if text_label.rect_position.y > TEXT_BOTTOM_Y && dialogues != null:
		next_part()

	time += delta * PRINT_SPEED
	if time >= 1:
		time = 0
		if text_label.visible_characters < text_label.text.length():
			text_label.visible_characters += 1

	if Input.is_action_just_pressed("ui_select"):
		yield(get_tree(), "idle_frame")
		if  text_label.visible_characters < text_label.text.length():
			text_label.visible_characters = text_label.text.length()
		else:
			is_text_printed = true

	if is_text_printed:
		text_label.rect_position.y += 1
		
	if text_label.visible_characters == text_label.text.length() && text_label.rect_position.y == TEXT_Y:
		$arrow.animation.current_animation = "blink"
	else:
		$arrow.animation.current_animation = "test"
		
		
func new_dialog(dialog:Array):
	is_dialog_completed = false
	dialogues = dialog.duplicate(true)
	next_part()
	visible = true
	position = g.cam_limit_pos
		
func next_part():
	text_label.rect_position.y = TEXT_Y
	text_label.visible_characters = 0
	is_text_printed = false
	if dialogues.empty():
		speaker_name_label.text = ""
		text_label.text = ""
		is_dialog_completed = true
	else:
		var t:Dictionary = dialogues.pop_front()
		text_label.text = t.values()[0]
		speaker_name_label.text = t.keys()[0]
		if "Dizzy" in speaker_name_label.text:
			speaker_name_label.align = speaker_name_label.ALIGN_LEFT
		else:
			speaker_name_label.align = speaker_name_label.ALIGN_RIGHT
		$ColorRect/dizzy_avatar.visible = "Dizzy" in speaker_name_label.text
		$ColorRect/danny_avatar.visible = "Danny" in speaker_name_label.text
