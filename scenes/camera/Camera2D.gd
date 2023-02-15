extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	g.camera = self
	limit_left = -g.world_width/2
	limit_right = g.world_width/2
	limit_top = -g.world_height/2
	limit_bottom = g.world_height/2
	offset = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !g.is_cutscene_playing && is_instance_valid(g.dizzy):
		
		position.x = g.dizzy.position.x #- g.camera_width / 2
		position.y = g.dizzy.position.y #- g.camera_height / 2

#func cutscene_danny_on_tree():
#	$show_danny.current_animation = "show_danny_on_tree"
#
#func to_dizzy():
#	$show_danny.current_animation = "to_dizzy"
