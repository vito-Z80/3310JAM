extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
#func _ready():
#	$AnimationPlayer.play("test")
#	visible = false

func set_left():
	$AnimationPlayer.play("left")
	visible = true
func set_right():
	$AnimationPlayer.play("right")
	visible = true
func set_blink():
	$AnimationPlayer.play("blink")
	visible = true
