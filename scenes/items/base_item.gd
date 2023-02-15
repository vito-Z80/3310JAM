extends Area2D

enum STATE {STAY, DROP, DESTROY}
# вещи с которыми комбинируется данная вещь
export(Array) var combined_with
# результат комбинации (новая вещь)
export(Dictionary) var result_combine
export(int, "Stay", "Drop", "Destroy") var after_combine

export(Texture) var texture

# All items must contains "item_" on name.

func _ready():
	print(STATE.DROP)
	if texture != null:
		$Sprite.texture = texture

var timer = 0.0
func _process(delta):
	if visible:
		timer += delta
		if timer > 0.3:
			timer = 0.0
			position.x = int(position.x) ^ 1
			position.y = int(position.y) ^ 1
